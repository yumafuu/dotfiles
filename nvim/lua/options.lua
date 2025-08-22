local hl = vim.api.nvim_set_hl

vim.cmd("colorscheme nord")
vim.cmd("set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC")
hl(0, "NormalFloat", { bg = "None" })
hl(0, "FloatBorder", { fg = "#444444" })
hl(0, "ActiveWindow", { bg = "None" })
hl(0, "InactiveWindow", { bg = "None" })
hl(0, "LineNr", { fg = "#C0C0C0" })
hl(0, "CursorLineNr", { fg = "#66C1FF" })
hl(0, "NotifyBackground", { bg = "None" })
hl(0, "TelescopeNormal", { bg = "None" })
hl(1, "HlSearchNear", { bg = "#444444", fg = "#7CB0FF" })
hl(0, "HlSearchLens", { bg = None, fg = "#7CB0FF" })
hl(0, "HlSearchLensNear", { bg = "None", fg = "#7BAFDA" })

vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.did_indent_on = 1
vim.g.did_load_filetypes = 1
vim.g.did_load_ftplugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.skip_loading_mswin = 1

vim.diagnostic.config({
  float = { border = "rounded" },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local o = vim.opt

o.fillchars = {
  vert = "│",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  eob = " ",
}
o.termguicolors = true
o.confirm = true
o.ts = 4
o.backup = false
o.swapfile = false
o.compatible = false
o.cursorline = false
o.cursorcolumn = false
o.smartindent = true
o.showmatch = true
o.autoindent = true
o.smarttab = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.list = true
o.listchars = { tab = "▸-", trail = "·", extends = "»", precedes = "«", nbsp = "%" }
o.fileformats = "unix,dos,mac"
o.fileencodings = "utf-8,sjis"
o.hlsearch = true
o.ignorecase = true
o.ruler = true
o.autoread = true
o.backspace = "indent,eol,start"
o.exrc = true
o.secure = true
o.nu = true
o.wildmenu = true
o.wildmode = "full"
o.encoding = "UTF-8"
o.splitbelow = true
o.splitright = true
o.foldtext = "FoldCCtext()"
o.clipboard:append({ "unnamedplus" })
o.laststatus = 3
o.cmdheight = 1

-- vim.api.nvim_create_augroup( 'lua', {} )
-- vim.api.nvim_create_autocmd( 'bufwritepre', {
--   group = 'lua',
--   callback = function() print('insert enter') end
-- })

if vim.fn.has("linux") == 1 then
  vim.g.clipboard = {
    name = "lemonade",
    copy = {
      ["+"] = "lemonade copy",
      ["*"] = "lemonade copy",
    },
    paste = {
      ["+"] = "lemonade paste",
      ["*"] = "lemonade paste",
    },
    cache_enabled = 0,
  }
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local map = vim.api.nvim_set_keymap
maps = {
  n = {
    ["te"] = '<cmd>execute ":tabedit" expand("%:h")<CR>',
    ["tt"] = '<cmd>execute ":tab split"<CR>',
    ["<C-[><C-[>"] = "<cmd>noh<CR><Esc>",
    ["C-l"] = "<cmd>noh<CR>",
    ["<C-[><C-[>"] = "<cmd>noh<CR>",
    ["<ECS><ECS>"] = "<cmd>noh<CR>",
    ["j"] = "gj",
    ["k"] = "gk",
    ["R"] = "<Plug>(operator-replace)",
    ["<Leader>c"] = "<plug>(operator-camelize-toggle)",
    ["<C-n>"] = "<cmd>tabnext<CR>",
    ["<C-p>"] = "<cmd>tabprevious<CR>",
    ["tv"] = "<cmd>vsplit | terminal<CR>",
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",
  },
  i = {
    ["<C-h>"] = "<Left>",
    ["<C-l>"] = "<Right>",
  },
  v = {
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",
  },
}

for mode, _maps in pairs(maps) do
  for k, v in pairs(_maps) do
    vim.keymap.set(mode, k, v, { noremap = true, silent = true })
  end
end

vim.cmd([[
" ターミナルを開いたらに常にinsertモードに入る
autocmd TermOpen * :startinsert
" ターミナルモードで行番号を非表示
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber

tnoremap <C-W><C-J>   <cmd>wincmd j<cr>
tnoremap <C-W>j       <cmd>wincmd j<cr>
tnoremap <C-W><C-K>   <cmd>wincmd k<cr>
tnoremap <C-W>k       <cmd>wincmd k<cr>
tnoremap <C-W><C-H>   <cmd>wincmd h<cr>
tnoremap <C-W>h       <cmd>wincmd h<cr>
tnoremap <C-W><C-L>   <cmd>wincmd l<cr>
tnoremap <C-W>l       <cmd>wincmd l<cr>

command R Dispatch
]])

vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })

vim.cmd([[
  " mark jump
  nnoremap ] `
]])

vim.cmd([[
  " ref: https://zenn.dev/vim_jp/articles/43d021f461f3a4

  " ペースト時にインデントを保持
  nnoremap p ]p`]
  nnoremap P ]P`]

  " git diff
  command! GitDiff new
      \ | setlocal buftype=nofile bufhidden=delete noswapfile
      \ | setfiletype gitcommit
      \ | execute 'read !git diff #'
      \ | setlocal readonly nobuflisted
      \ | normal! gg
  nnoremap ds <cmd>GitDiff<cr>


  " :memoで :e {gitroot}/.yuma/{branch}/memo.md を開く
  command! -nargs=0 Memo execute 'silent! call mkdir((isdirectory(system("git rev-parse --show-toplevel 2>/dev/null | tr -d \"\\n\"")) ? substitute(system("git rev-parse --show-toplevel"), "\n", "", "") . "/.yuma/" . substitute(system("git rev-parse --abbrev-ref HEAD"), "\n", "", "") : "memo"), "p")' | execute 'e ' . (isdirectory(system('git rev-parse --show-toplevel 2>/dev/null | tr -d "\\n"')) ? substitute(system('git rev-parse --show-toplevel'), '\n', '', '') . '/.yuma/' . substitute(system('git rev-parse --abbrev-ref HEAD'), '\n', '', '') . '/memo.md' : 'memo/memo.md')

]])

local function copy_current_path()
  local bufname = vim.api.nvim_buf_get_name(0)
  local prefix = "oil://"
  local fullpath = bufname
  if fullpath:sub(1, #prefix) == prefix then
    fullpath = fullpath:sub(#prefix + 1)
  end
  local cwd = vim.fn.getcwd()
  local relpath = vim.fn.fnamemodify(fullpath, ":.")
  vim.fn.setreg("+", relpath)
  vim.notify("Copied path: " .. relpath, vim.log.levels.INFO)
end

vim.keymap.set({ "n", "v" }, "<leader>l", copy_current_path, { noremap = true, silent = true })

local function select_ABC()
  vim.fn.jobstart({ "/opt/homebrew/bin/im-select", "com.apple.keylayout.ABC" }, { detach = true })
end
-- Create the autocmd
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = select_ABC,
  desc = "Restore ABC input source after leaving insert mode",
})

-- クリップボードの内容でバッファを全上書き
local function replace_buffer_with_clipboard()
  -- クリップボードの内容を取得
  local clipboard = vim.fn.getreg("+")
  if clipboard == nil or clipboard == "" then
    vim.notify("Clipboard is empty", vim.log.levels.WARN)
    return
  end

  -- バッファ全体を書き換え
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(clipboard, "\n"))
end
vim.keymap.set("n", "<leader>p", replace_buffer_with_clipboard, { desc = "Replace buffer with clipboard" })

vim.keymap.set("n", "gq", function()
  local file = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(file) == 1 then
    vim.cmd.edit(file)
  else
    if vim.fn.confirm(file .. " does not exist. Create?", "&Yes\n&No", 1) == 1 then
      vim.cmd.edit(file)
    end
  end
end, { noremap = true, silent = true })
