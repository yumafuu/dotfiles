-- Save to ~/.hammerspoon
-- In ~/.hammerspoon/init.lua:
--    local vimouse = require('vimouse')
--    vimouse('cmd', 'm')
--
-- This sets cmd-m as the key that toggles Vi Mouse.
--
-- WASD or HJKL moves the mouse cursor smoothly.
-- W/K - up, A/H - left, S/J - down, D/L - right
-- Holding shift makes movement 3x faster.
-- Holding cmd makes movement 2x faster (stacks with shift).
-- Holding alt makes movement 0.5x slower.
--
-- Pressing <space> sends left mouse down.  Releasing <space> sends left mouse
-- up.  Holding <space> and pressing WASD/HJKL is mouse dragging.  Tapping
-- <space> quickly sends double and triple clicks.  Holding ctrl sends right
-- mouse events.
--
-- <c-y> and <c-e> sends the scroll wheel event.  Holding the keys will speed
-- up the scrolling.
--
-- Press <esc> or the configured toggle key to end Vi Mouse mode.

return function(tmod, tkey)
   -- local overlay = nil
   local log = hs.logger.new("vimouse", "debug")
   local tap = nil
   local orig_coords = nil
   local dragging = false
   local scrolling = 0
   local mousedown_time = 0
   local mousepress_time = 0
   local mousepress = 0
   local tapmods = { ["cmd"] = false, ["ctrl"] = false, ["alt"] = false, ["shift"] = false }

   -- Smooth movement variables
   local moveTimer = nil
   local moveVelocity = { x = 0, y = 0 }
   local baseSpeed = 10 -- pixels per frame
   local smoothAcceleration = 1.5 -- acceleration factor
   local rightShiftPressed = false -- Track right shift state
   local activeKeys = { w = false, a = false, s = false, d = false, h = false, j = false, k = false, l = false } -- Track active movement keys

   if type(tmod) == "string" then
      tapmods[tmod] = true
   else
      for _, name in ipairs(tmod) do
         tapmods[name] = true
      end
   end

   local eventTypes = hs.eventtap.event.types
   local eventPropTypes = hs.eventtap.event.properties
   local keycodes = hs.keycodes.map

   -- Smooth movement function
   local function updateMousePosition()
      if moveVelocity.x ~= 0 or moveVelocity.y ~= 0 then
         local coords = hs.mouse.getAbsolutePosition()
         coords.x = coords.x + moveVelocity.x
         coords.y = coords.y + moveVelocity.y

         if dragging then
            postEvent(eventTypes.leftMouseDragged, coords, {}, 0)
         else
            hs.mouse.setAbsolutePosition(coords)
         end
      end
   end

   -- Start smooth movement timer
   local function startSmoothMovement()
      if moveTimer == nil then
         moveTimer = hs.timer.doEvery(0.01, updateMousePosition) -- 100 FPS
      end
   end

   -- Stop smooth movement timer
   local function stopSmoothMovement()
      if moveTimer then
         moveTimer:stop()
         moveTimer = nil
      end
      moveVelocity.x = 0
      moveVelocity.y = 0
   end

   -- Update movement velocity based on active keys
   local function updateVelocity(flags)
      local speed = baseSpeed
      
      -- Adjust speed with modifiers
      if flags.shift then
         speed = speed * 3 -- Faster with shift
      end
      if flags.cmd then
         speed = speed * 2 -- Even faster with cmd
      elseif flags.alt then
         speed = speed * 0.5 -- Slower with alt
      end
      
      -- Calculate velocity based on active keys
      moveVelocity.x = 0
      moveVelocity.y = 0
      
      if activeKeys.w or activeKeys.k then
         moveVelocity.y = moveVelocity.y - speed
      end
      if activeKeys.s or activeKeys.j then
         moveVelocity.y = moveVelocity.y + speed
      end
      if activeKeys.a or activeKeys.h then
         moveVelocity.x = moveVelocity.x - speed
      end
      if activeKeys.d or activeKeys.l then
         moveVelocity.x = moveVelocity.x + speed
      end
      
      -- Start or stop movement based on velocity
      if moveVelocity.x ~= 0 or moveVelocity.y ~= 0 then
         startSmoothMovement()
      else
         stopSmoothMovement()
      end
   end

   function postEvent(et, coords, modkeys, clicks)
      local e = hs.eventtap.event.newMouseEvent(et, coords, modkeys)
      if clicks > 3 then
         clicks = 3
      end
      e:setProperty(eventPropTypes.mouseEventClickState, clicks)
      e:post()
   end

   tap = hs.eventtap.new({ eventTypes.keyDown, eventTypes.keyUp, eventTypes.flagsChanged }, function(event)
      local code = event:getKeyCode()
      local flags = event:getFlags()
      local repeating = event:getProperty(eventPropTypes.keyboardEventAutorepeat)
      local coords = hs.mouse.getAbsolutePosition()
      local eventType = event:getType()

      -- Track right shift state (right shift keycode is 60)
      if eventType == eventTypes.flagsChanged and code == 60 then
         rightShiftPressed = flags.shift
         -- Update velocity when shift state changes
         if activeKeys.w or activeKeys.a or activeKeys.s or activeKeys.d or 
            activeKeys.h or activeKeys.j or activeKeys.k or activeKeys.l then
            updateVelocity(flags)
         end
         return false -- Allow other apps to see shift key
      end

      -- Handle WASD and HJKL for smooth movement
      local keyMap = {
         [keycodes["w"]] = "w",
         [keycodes["a"]] = "a",
         [keycodes["s"]] = "s",
         [keycodes["d"]] = "d",
         [keycodes["h"]] = "h",
         [keycodes["j"]] = "j",
         [keycodes["k"]] = "k",
         [keycodes["l"]] = "l"
      }
      
      local key = keyMap[code]
      if key then
         if eventType == eventTypes.keyDown then
            if not repeating or repeating == 0 then
               activeKeys[key] = true
               updateVelocity(flags)
            end
            return true
         elseif eventType == eventTypes.keyUp then
            activeKeys[key] = false
            updateVelocity(flags)
            return true
         end
      end

      if (code == keycodes.tab or code == keycodes["`"]) and flags.cmd then
         -- Window cycling
         return false
      end

      if code == keycodes.space then
         -- Mouse clicking
         if repeating ~= 0 then
            return true
         end

         local btn = "left"
         if flags.ctrl then
            btn = "right"
         end

         local now = hs.timer.secondsSinceEpoch()
         if now - mousepress_time > hs.eventtap.doubleClickInterval() then
            mousepress = 1
         end

         if event:getType() == eventTypes.keyUp then
            dragging = false
            postEvent(eventTypes[btn .. "MouseUp"], coords, flags, mousepress)
         elseif event:getType() == eventTypes.keyDown then
            dragging = true
            if now - mousedown_time <= 0.3 then
               mousepress = mousepress + 1
               mousepress_time = now
            end

            mousedown_time = hs.timer.secondsSinceEpoch()
            postEvent(eventTypes[btn .. "MouseDown"], coords, flags, mousepress)
         end

         orig_coords = coords
      elseif event:getType() == eventTypes.keyDown then
         local scroll_y_delta = 0
         local is_tapkey = code == keycodes[tkey]

         if is_tapkey == true then
            for name, _ in pairs(tapmods) do
               if flags[name] == nil then
                  flags[name] = false
               end

               if tapmods[name] ~= flags[name] then
                  is_tapkey = false
                  break
               end
            end
         end

         if is_tapkey or code == keycodes["escape"] then
            if dragging then
               postEvent(eventTypes.leftMouseUp, coords, flags, 0)
            end
            dragging = false
            stopSmoothMovement() -- Stop smooth movement when exiting
            rightShiftPressed = false -- Reset right shift state
            activeKeys = { w = false, a = false, s = false, d = false, h = false, j = false, k = false, l = false } -- Reset active keys
            -- overlay:delete()
            -- overlay = nil
            hs.alert("Vi Mouse Off")
            tap:stop()
            hs.mouse.setAbsolutePosition(orig_coords)
            return true
         elseif (code == keycodes["y"] or code == keycodes["e"]) and flags.ctrl then
            if repeating ~= 0 then
               scrolling = scrolling + 1
            else
               scrolling = 1
            end

            local scroll_mul = 1 + math.log(scrolling)
            if code == keycodes["y"] then
               scroll_y_delta = math.ceil(-1 * scroll_mul)
            else
               scroll_y_delta = math.floor(1 * scroll_mul)
            end
            log.d("Scrolling", scrolling, "-", scroll_y_delta)
         end

         if scroll_y_delta ~= 0 then
            hs.eventtap.event.newScrollEvent({ 0, scroll_y_delta }, flags, "line"):post()
         end
      end
      return true
   end)

   hs.hotkey.bind(tmod, tkey, nil, function(event)
      local screen = hs.mouse.getCurrentScreen()
      local frame = screen:fullFrame()

      -- overlay = hs.drawing.rectangle(frame)
      -- overlay:setFillColor({['red']=0, ['blue']=0, ['green']=0, ['alpha']=0.2})
      -- overlay:setFill(true)
      -- overlay:setLevel(hs.drawing.windowLevels['assistiveTechHigh'])
      -- overlay:show()

      hs.alert("Vi Mouse On")
      orig_coords = hs.mouse.getAbsolutePosition()
      tap:start()
   end)
end
