hs.loadSpoon("Seal")

-- 読み込むプラグインを選ぶ
spoon.Seal:loadPlugins({
   "apps", -- アプリ起動（Spotlightベース）
   "filesearch", -- ファイル検索
   "pasteboard", -- クリップボード履歴
   "urlformats", -- URLテンプレ+クエリ挿入
   "useractions", -- 任意アクション
})

-- 例: useractionsにコマンド追加
spoon.Seal.plugins.useractions.actions = {
   ["メッセージを表示"] = {
      keyword = "say",
      fn = function(q)
         hs.alert.show(q)
      end,
   },
}

-- URLテンプレのプロバイダ（`uf` キーワードで使用）
spoon.Seal.plugins.urlformats:providersTable({
   gh = { name = "GitHub Issue", url = "https://github.com/owner/repo/issues/%s" },
   gg = { name = "Google 検索", url = "https://www.google.com/search?q=%s" },
})

-- クリップボード履歴
spoon.Seal.plugins.pasteboard.historySize = 200

-- ホットキー
spoon.Seal:bindHotkeys({ toggle = { { "cmd", "ctrl" }, "space" } })

spoon.Seal:start()

-- IME (Alacritty起動時のみ有効化)
local alacrittyFilter = hs.window.filter.new(false):setAppFilter("Alacritty")
if alacrittyFilter then
   alacrittyFilter:subscribe(hs.window.filter.windowFocused, function()
      hs.task.new("/opt/homebrew/bin/im-select", function() end, { "com.apple.keylayout.ABC" }):start()
   end)
end

-- リロードショートカット
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
   hs.reload()
   hs.alert.show("Config reloaded")
end)
hs.alert.show("Hammerspoon loaded!")

hs.hotkey.bind({ "alt", "ctrl" }, "h", function()
   local win = hs.window.focusedWindow()
   local f = win:frame()
   local screen = win:screen()
   local max = screen:frame()

   local widthRatio = f.w / max.w
   local posRatio = (f.x - max.x) / max.w
   local threshold = 0.05

   if math.abs(posRatio - 0) < threshold and math.abs(widthRatio - 1 / 3) < threshold then
      f.x = max.x + max.w * 2 / 3
      f.w = max.w / 3
   elseif math.abs(posRatio - 0) < threshold and math.abs(widthRatio - 1 / 2) < threshold then
      f.x = max.x
      f.w = max.w / 3
   elseif math.abs(posRatio - 0) < threshold and math.abs(widthRatio - 2 / 3) < threshold then
      f.x = max.x
      f.w = max.w / 2
   elseif math.abs(widthRatio - 1) < threshold then
      f.x = max.x
      f.w = max.w * 2 / 3
   elseif math.abs(posRatio - 1 / 3) < threshold and math.abs(widthRatio - 2 / 3) < threshold then
      win:maximize()
      return
   elseif math.abs(posRatio - 1 / 2) < threshold and math.abs(widthRatio - 1 / 2) < threshold then
      f.x = max.x + max.w / 3
      f.w = max.w * 2 / 3
   elseif math.abs(posRatio - 2 / 3) < threshold and math.abs(widthRatio - 1 / 3) < threshold then
      f.x = max.x + max.w / 2
      f.w = max.w / 2
   else
      f.x = max.x + max.w * 2 / 3
      f.w = max.w / 3
   end

   f.y = max.y
   f.h = max.h
   win:setFrame(f)
end)

hs.hotkey.bind({ "alt", "ctrl" }, "l", function()
   local win = hs.window.focusedWindow()
   local f = win:frame()
   local screen = win:screen()
   local max = screen:frame()

   local widthRatio = f.w / max.w
   local posRatio = (f.x - max.x) / max.w
   local threshold = 0.05

   if math.abs(posRatio - 2 / 3) < threshold and math.abs(widthRatio - 1 / 3) < threshold then
      f.x = max.x
      f.w = max.w / 3
   elseif math.abs(posRatio - 1 / 2) < threshold and math.abs(widthRatio - 1 / 2) < threshold then
      f.x = max.x + max.w * 2 / 3
      f.w = max.w / 3
   elseif math.abs(posRatio - 1 / 3) < threshold and math.abs(widthRatio - 2 / 3) < threshold then
      f.x = max.x + max.w / 2
      f.w = max.w / 2
   elseif math.abs(widthRatio - 1) < threshold then
      f.x = max.x + max.w / 3
      f.w = max.w * 2 / 3
   elseif math.abs(posRatio - 0) < threshold and math.abs(widthRatio - 2 / 3) < threshold then
      win:maximize()
      return
   elseif math.abs(posRatio - 0) < threshold and math.abs(widthRatio - 1 / 2) < threshold then
      f.x = max.x
      f.w = max.w * 2 / 3
   elseif math.abs(posRatio - 0) < threshold and math.abs(widthRatio - 1 / 3) < threshold then
      f.x = max.x
      f.w = max.w / 2
   else
      f.x = max.x
      f.w = max.w / 3
   end

   f.y = max.y
   f.h = max.h
   win:setFrame(f)
end)

hs.hotkey.bind({ "alt", "ctrl" }, "k", function()
   local win = hs.window.focusedWindow()
   win:maximize()
end)

hs.hotkey.bind({ "alt", "ctrl" }, "n", function()
   local win = hs.window.focusedWindow()
   if not win then
      return
   end

   local app = win:application()
   if not app then
      return
   end

   local windows = app:allWindows()
   if #windows <= 1 then
      return
   end

   local currentIndex = hs.fnutils.indexOf(windows, win)
   local nextIndex = (currentIndex % #windows) + 1

   windows[nextIndex]:focus()
end)

-- grid
hs.grid.setGrid("4x4")
hs.grid.setMargins("5x5")

hs.hotkey.bind({ "ctrl", "alt" }, "G", function()
   hs.grid.show()
end)

-- Chrome
-- Chrome のアクティブタブを新規ウィンドウに切り出す
local function moveChromeTabToNewWindow()
   local app = hs.application.frontmostApplication()
   if not app or app:name() ~= "Google Chrome" then
      -- Chrome 以外が前面なら何もしない
      return
   end

   local script = [[
tell application "Google Chrome"
    if (count of windows) is 0 then return

    set theWin to front window
    if (count of tabs of theWin) is 0 then return

    set theTab to active tab of theWin
    set theURL to URL of theTab

    -- 新しいウィンドウを作成
    set newWin to make new window

    -- 新ウィンドウの空タブに URL を設定
    set URL of active tab of newWin to theURL

    -- 新しいウィンドウを最前面に
    set index of newWin to 1
end tell
  ]]

   hs.osascript.applescript(script)
end

-- ホットキー登録（Ctrl + Alt + Cmd + T）
hs.hotkey.bind({ "ctrl", "alt" }, "p", moveChromeTabToNewWindow)
