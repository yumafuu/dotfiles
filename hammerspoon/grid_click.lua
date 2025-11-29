-- ~/.hammerspoon/grid_click.lua

local M = {}

-- 設定
local GRID_ROWS = 3
local GRID_COLS = 3

local modal = nil
local currentRect = nil
local lastCenter = nil

------------------------------------------------------------
-- ユーティリティ
------------------------------------------------------------

local function getInitialRect()
   -- 現在のマウス位置 or フォーカスウィンドウのスクリーン
   local mousePos = hs.mouse.absolutePosition()
   local screen = hs.screen.mainScreen()

   if mousePos then
      local s = hs.screen.screenForPoint(mousePos)
      if s then
         screen = s
      end
   end

   local frame = screen:fullFrame()
   return frame
end

local function centerOfRect(rect)
   return {
      x = rect.x + rect.w / 2,
      y = rect.y + rect.h / 2,
   }
end

local function moveMouseToRect(rect)
   local c = centerOfRect(rect)
   lastCenter = c
   hs.mouse.setAbsolutePosition(c)
end

local function resetGrid()
   currentRect = getInitialRect()
   moveMouseToRect(currentRect)
end

local function selectCell(index)
   if not currentRect then
      resetGrid()
   end

   -- index: 1〜9 を想定（3x3前提）
   if index < 1 or index > GRID_ROWS * GRID_COLS then
      return
   end

   local row = math.floor((index - 1) / GRID_COLS)
   local col = (index - 1) % GRID_COLS

   local cellW = currentRect.w / GRID_COLS
   local cellH = currentRect.h / GRID_ROWS

   local newRect = {
      x = currentRect.x + col * cellW,
      y = currentRect.y + row * cellH,
      w = cellW,
      h = cellH,
   }

   currentRect = newRect
   moveMouseToRect(currentRect)
end

local function leftClick()
   local pos = hs.mouse.absolutePosition()
   hs.eventtap.leftClick(pos, 0)
end

local function rightClick()
   local pos = hs.mouse.absolutePosition()
   hs.eventtap.rightClick(pos, 0)
end

------------------------------------------------------------
-- モーダル
------------------------------------------------------------

local function enterModal()
   if not modal then
      modal = hs.hotkey.modal.new()
   end

   -- 状態初期化
   resetGrid()

   -- すでにバインドされてる場合は一度解除
   modal:unbindAll()

   -- 終了
   modal:bind({}, "escape", "exit grid mode", function()
      modal:exit()
   end)

   -- 全画面にリセット
   modal:bind({}, "0", "reset grid", function()
      resetGrid()
   end)

   -- 左クリック
   modal:bind({}, "space", "left click", function()
      leftClick()
      modal:exit()
   end)
   modal:bind({}, "return", "left click", function()
      leftClick()
      modal:exit()
   end)

   -- 右クリック
   modal:bind({}, "r", "right click", function()
      rightClick()
      modal:exit()
   end)

   -- 1〜9 でセル選択（3x3 用）
   for i = 1, (GRID_ROWS * GRID_COLS) do
      local key = tostring(i)
      modal:bind({}, key, "select cell " .. key, function()
         selectCell(i)
      end)
   end

   modal:enter()
   hs.alert.show("Grid Click Mode", 0.5)
end

------------------------------------------------------------
-- 公開 API
------------------------------------------------------------

function M.bind(hyper, key)
   -- 例: M.bind({"ctrl", "alt", "cmd", "shift"}, "g")
   hs.hotkey.bind(hyper, key, function()
      enterModal()
   end)
end

return M
