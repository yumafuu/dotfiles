-- lua/quicktest/adapters/gorun.lua
local Job = require("plenary.job")

local M = {
  name = "gorun",
}

---@class GoRunParams
---@field bufnr integer
---@field cursor_pos integer[]
---@field pkg string         -- 実行対象のパッケージ/ディレクトリ (例: ./cmd/app)
---@field main string|nil    -- mainファイルを直指定したい場合 (例: ./cmd/app/main.go)
---@field args string[]      -- go run 以降に渡す引数

-- カーソル行から適当に推測する例（必要なら好きにカスタマイズ）
local function guess_pkg_from_buf(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    return "./"
  end
  -- go.mod のあるルートからの相対にしたい場合は、ここで探して相対化するなど。
  -- とりあえず現在ファイルのディレクトリをパッケージとして使う。
  return vim.fn.fnamemodify(fname, ":h")
end

-- 行単位実行のパラメータ構築（任意）
M.build_line_run_params = function(bufnr, cursor_pos)
  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    pkg = guess_pkg_from_buf(bufnr),
    args = {}, -- 行実行時の追加引数があればここに
  },
    nil
end

-- ファイル単位のパラメータ構築（任意）
M.build_file_run_params = function(bufnr, cursor_pos)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    -- main.go を直指定したいなら main に入れる
    main = fname:match("main%.go$") and fname or nil,
    pkg = guess_pkg_from_buf(bufnr),
    args = {},
  },
    nil
end

-- ディレクトリ／プロジェクト実行も必要なら同様に build_dir_run_params / build_all_run_params を定義

--- 実行本体（必須）
---@param params GoRunParams
---@param send fun(data: any)
---@return integer
M.run = function(params, send)
  -- コマンド組み立て
  local cmd = "go"
  local args = { "run" }

  if params.main then
    table.insert(args, params.main)
  else
    -- パッケージ（ディレクトリ）指定で run
    table.insert(args, params.pkg or "./")
  end

  -- 追加のプログラム引数
  if params.args and #params.args > 0 then
    for _, a in ipairs(params.args) do
      table.insert(args, a)
    end
  end

  local job = Job:new({
    command = cmd,
    args = args,
    cwd = params.pkg or vim.fn.getcwd(),
    on_stdout = function(_, data)
      if data and #data > 0 then
        send({ type = "stdout", output = data })
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        send({ type = "stderr", output = data })
      end
    end,
    on_exit = function(_, code)
      send({ type = "exit", code = code })
    end,
  })

  job:start()
  return job.pid
end

-- タイトル（任意）
M.title = function(params)
  local target = params.main or params.pkg or "./"
  return ("go run %s"):format(target)
end

-- このアダプタをいつ有効にするか（任意）
M.is_enabled = function(bufnr)
  -- goファイルのときだけ有効にする簡易判定
  return vim.api.nvim_buf_get_name(bufnr):match("%.go$") ~= nil
end

return M
