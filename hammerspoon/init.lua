local imeApp = "Alacritty"

hs.window.filter.new(imeApp):subscribe(hs.window.filter.windowFocused, function()
   hs.task.new("/opt/homebrew/bin/im-select", function() end, { "com.apple.keylayout.ABC" }):start()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
   hs.alert.show("Hello World!")
end)
