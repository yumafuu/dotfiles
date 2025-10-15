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

-- IME
hs.window.filter.new("Alacritty"):subscribe(hs.window.filter.windowFocused, function()
   hs.task.new("/opt/homebrew/bin/im-select", function() end, { "com.apple.keylayout.ABC" }):start()
end)
