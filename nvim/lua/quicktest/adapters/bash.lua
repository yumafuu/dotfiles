local Job = require("plenary.job")

local M = {
  name = "bash",
}

---@class BashParams
---@field bufnr integer
---@field cursor_pos integer[]
---@field script string|nil    -- Script file path to execute
---@field command string|nil   -- Command string to execute directly
---@field args string[]        -- Arguments to pass to bash
---@field cwd string|nil       -- Working directory for execution

-- Extract command from cursor line
local function get_line_command(bufnr, cursor_pos)
  local lines = vim.api.nvim_buf_get_lines(bufnr, cursor_pos[1] - 1, cursor_pos[1], false)
  if #lines > 0 then
    local line = lines[1]
    -- Skip comment lines and empty lines
    if line:match("^%s*#") or line:match("^%s*$") then
      return nil
    end
    return line
  end
  return nil
end

-- Build parameters for line execution
M.build_line_run_params = function(bufnr, cursor_pos)
  local command = get_line_command(bufnr, cursor_pos)
  if not command then
    return nil, "No executable command on current line"
  end

  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    command = command,
    args = {},
    cwd = vim.fn.getcwd(),
  },
    nil
end

-- Build parameters for file execution
M.build_file_run_params = function(bufnr, cursor_pos)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then
    return nil, "No file name"
  end

  return {
    bufnr = bufnr,
    cursor_pos = cursor_pos,
    script = fname,
    args = {},
    cwd = vim.fn.fnamemodify(fname, ":h"),
  },
    nil
end

-- Directory execution (look for test.sh or run.sh)
M.build_dir_run_params = function(bufnr, cursor_pos)
  local cwd = vim.fn.getcwd()

  -- Look for common script names
  local scripts = { "test.sh", "run.sh", "build.sh", "start.sh" }
  for _, script in ipairs(scripts) do
    local path = cwd .. "/" .. script
    if vim.fn.filereadable(path) == 1 then
      return {
        bufnr = bufnr,
        cursor_pos = cursor_pos,
        script = path,
        args = {},
        cwd = cwd,
      },
        nil
    end
  end

  return nil, "No executable script found in directory"
end

--- Run the command (required)
---@param params BashParams
---@param send fun(data: any)
---@return integer
M.run = function(params, send)
  local cmd = "bash"
  local args = {}

  if params.script then
    -- Execute script file
    table.insert(args, params.script)
  elseif params.command then
    -- Execute command directly
    table.insert(args, "-c")
    table.insert(args, params.command)
  else
    send({ type = "stderr", output = "No script or command specified" })
    send({ type = "exit", code = 1 })
    return -1
  end

  -- Additional arguments
  if params.args and #params.args > 0 then
    for _, a in ipairs(params.args) do
      table.insert(args, a)
    end
  end

  local job = Job:new({
    command = cmd,
    args = args,
    cwd = params.cwd or vim.fn.getcwd(),
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

-- Title (optional)
M.title = function(params)
  if params.script then
    return ("bash %s"):format(vim.fn.fnamemodify(params.script, ":t"))
  elseif params.command then
    local cmd = params.command
    if #cmd > 30 then
      cmd = cmd:sub(1, 27) .. "..."
    end
    return ("bash -c '%s'"):format(cmd)
  end
  return "bash"
end

-- When to enable this adapter (optional)
M.is_enabled = function(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  -- .sh or .bash files
  if fname:match("%.sh$") or fname:match("%.bash$") then
    return true
  end

  -- Check shebang for any file
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)
  if #lines > 0 then
    local shebang = lines[1]
    if shebang:match("^#!/.*bash") or shebang:match("^#!/bin/sh") or shebang:match("^#!/usr/bin/env%s+bash") then
      return true
    end
  end

  return false
end

return M
