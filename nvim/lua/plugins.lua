return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    dir = "~/ghq/github.com/yumafuu/sse-mcp.nvim",
    config = function()
      require("sse-mcp").setup({
        auto_start = true,
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "?", mode = { "n", "x", "o" }, function() require("flash").jump() end },
      { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
      { "f", mode = { "n", "x", "o" }, function() require("flash").jump({ mode = "char" }) end },
      { "F", mode = { "n", "x", "o" }, function() require("flash").jump({ mode = "char", backward = true }) end },
      { "t", mode = { "n", "x", "o" }, function() require("flash").jump({ mode = "char", jump_labels = false }) end },
      { "T", mode = { "n", "x", "o" }, function() require("flash").jump({ mode = "char", jump_labels = false, backward = true }) end },
    },
    config = function()
      require("flash").setup({
        highlight = {
          backdrop = true,
          matches = true,
          minimal_jump = true,
        },
      })
    end,
  },
  {
    "tapihdev/cfp.nvim",
    config = function()
      require("cfp").setup({
        keymaps = {
          copy_path = "<leader>l",
          copy_path_line = "L",
          copy_branch_url = "<leader>gl",
          copy_branch_url_line = "gL",
          copy_hash_url = "<leader>gh",
          copy_hash_url_line = "gH",
        },
        -- your configuration comes here
        -- or leave it empty to use the default settings
      })
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    lazy = true,
    ft = "qf",
    config = function()
      local fn = vim.fn

      function _G.qftf(info)
        local items
        local ret = {}
        -- The name of item in list is based on the directory of quickfix window.
        -- Change the directory for quickfix window make the name of item shorter.
        -- It's a good opportunity to change current directory in quickfixtextfunc :)
        --
        -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
        -- local root = getRootByAlterBufnr(alterBufnr)
        -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
        --
        if info.quickfix == 1 then
          items = fn.getqflist({ id = info.id, items = 0 }).items
        else
          items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
        end
        local limit = 31
        local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
        local validFmt = "%s │%5d:%-3d│%s %s"
        for i = info.start_idx, info.end_idx do
          local e = items[i]
          local fname = ""
          local str
          if e.valid == 1 then
            if e.bufnr > 0 then
              fname = fn.bufname(e.bufnr)
              if fname == "" then
                fname = "[No Name]"
              else
                fname = fname:gsub("^" .. vim.env.HOME, "~")
              end
              -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
              if #fname <= limit then
                fname = fnameFmt1:format(fname)
              else
                fname = fnameFmt2:format(fname:sub(1 - limit))
              end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
          else
            str = e.text
          end
          table.insert(ret, str)
        end
        return ret
      end

      vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

      -- ハイライト設定を先に行う
      vim.cmd([[
        highlight BqfPreviewFloat guibg=NONE
        highlight BqfPreviewBorder guifg=#444444 guibg=NONE
        highlight BqfPreviewCursorLine guibg=#2e3440
        highlight link BqfPreviewRange IncSearch
        highlight BqfSign guifg=#66C1FF
      ]])

      require("bqf").setup({
        auto_enable = true,
        func_map = {
          vsplit = "",
        },
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border = "rounded",
          show_title = false,
          winblend = 0, -- 透過度を0に設定
        },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ["?"] = "actions.show_help",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["<C-l>"] = "actions.refresh",
          ["<CR>"] = "actions.select",
          ["<C-t>"] = "actions.select_tab",
          ["<C-i>"] = "actions.preview",
          ["g."] = "actions.toggle_hidden",
          ["~"] = "actions.tcd",
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = true,
        },
        git = {
          add = function() return false end,
          mv = function() return false end,
          rm = function() return false end,
        },
        columns = {
          -- "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
      })

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.keymap.set("n", "<leader>f", function()
        local dir = vim.fn.expand("%:h")
        if dir == "" then dir = vim.fn.getcwd() end
        vim.cmd("e " .. dir)
      end, { noremap = true, silent = true })
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          terraform = { "terraform_fmt" },
          json = { "deno_fmt" },
          go = { "gofumpt" },
          markdown = { "markdownlint-cli2" },
        },
        formatters = {
          deno_fmt = {
            command = "deno",
            args = {
              "fmt",
              "--ext",
              "json",
              "--line-width",
              "100",
              "-",
            },
            stdin = true,
          },
        },
      })
    end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    keys = {
      { "<leader>e", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
      { "<leader>r", "<cmd>OverseerRun<cr>", desc = "Run Task" },
      -- { "<space>ec", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
      -- { "<space>eq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
      -- { "<space>ea", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
      -- { "<space>ei", "<cmd>OverseerInfo<cr>", desc = "Info" },
    },
    config = function()
      overseer = require("overseer")

      overseer.setup({
        select = "fzf_lua",

        form = {
          border = "rounded",
          win_opts = {
            winblend = 0,
            winhighlight = "Normal:MyNormal,NormalNC:MyNormalNC",
          },
        },
        confirm = {
          border = "rounded",
          win_opts = {
            winblend = 0,
            winhighlight = "Normal:MyNormal,NormalNC:MyNormalNC",
          },
        },
        task_win = {
          border = "rounded",
          win_opts = {
            winblend = 0,
            winhighlight = "Normal:MyNormal,NormalNC:MyNormalNC",
          },
        },
      })
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    opts = {},
  },
  {
    "chrisgrieser/nvim-recorder",
    opts = {}, -- required
  },
  {
    "ysmb-wtsg/in-and-out.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("i", "<C-k>", function() require("in-and-out").in_and_out() end)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "right", -- | top | left | right | horizontal | vertical
            ratio = 0.3,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false,
          debounce = 75,
          keymap = {
            accept = "<C-]>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-.>",
          },
        },
      })
    end,
  },
  {
    "quolpr/quicktest.nvim",
    event = "VeryLazy",
    config = function()
      local qt = require("quicktest")

      qt.setup({
        -- Choose your adapter, here all supported adapters are listed
        adapters = {
          require("quicktest.adapters.golang")({}),
          require("quicktest.adapters.gorun"),
          require("quicktest.adapters.bash"),
          require("quicktest.adapters.vitest")({}),
          require("quicktest.adapters.playwright")({}),
        },
        -- split or popup mode, when argument not specified
        default_win_mode = "popup",
        use_builtin_colorizer = true,
      })
    end,
    keys = {
      {
        "<leader>tl",
        function()
          local qt = require("quicktest")
          -- current_win_mode return currently opened panel, split or popup
          qt.run_line()
          -- You can force open split or popup like this:
          -- qt.run_line('split')
          -- qt.run_line('popup')
        end,
        desc = "[T]est Run [L]line",
      },
      {
        "<leader>tf",
        function()
          local qt = require("quicktest")

          qt.run_file()
        end,
        desc = "[T]est Run [F]ile",
      },
      {
        "<leader>td",
        function()
          local qt = require("quicktest")

          qt.run_dir()
        end,
        desc = "[T]est Run [D]ir",
      },
      {
        "<leader>ta",
        function()
          local qt = require("quicktest")

          qt.run_all()
        end,
        desc = "[T]est Run [A]ll",
      },
      {
        "<leader>tp",
        function()
          local qt = require("quicktest")

          qt.run_previous()
        end,
        desc = "[T]est Run [P]revious",
      },
      {
        "<leader>tt",
        function()
          local qt = require("quicktest")

          qt.toggle_win("split")
        end,
        desc = "[T]est [T]oggle Window",
      },
      {
        "<leader>tc",
        function()
          local qt = require("quicktest")

          qt.cancel_current_run()
        end,
        desc = "[T]est [C]ancel Current Run",
      },
    },
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "RRethy/vim-illuminate", event = "VeryLazy" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function() require("nvim-highlight-colors").setup() end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    lazy = true,
    version = "*",
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "kjuq/sixelview.nvim",
    opts = {},
  },
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   opts = {}, -- your configuration
  -- },
  {
    "TobinPalmer/rayso.nvim",
    lazy = true,
    cmd = { "Rayso" },
    config = function() require("rayso").setup({}) end,
  },
  {
    "rapan931/lasterisk.nvim",
    lazy = true,
    config = function()
      vim.keymap.set("n", "*", function()
        require("lasterisk").search()
        require("hlslens").start()
      end)

      vim.keymap.set({ "n", "x" }, "g*", function()
        require("lasterisk").search({ is_whole = false })
        require("hlslens").start()
      end)
    end,
  },
  {
    "hrsh7th/nvim-insx",
    lazy = true,
    tag = "v1.1.0",
    config = function() require("insx.preset.standard").setup() end,
  },
  {
    "kana/vim-operator-user",
    lazy = false,
  },
  {
    "kana/vim-operator-replace",
    lazy = false,
    dependencies = { "kana/vim-operator-user" },
  },
  {
    "echasnovski/mini.extra",
    lazy = false,
    config = function() require("mini.extra").setup() end,
  },
  {
    "echasnovski/mini.ai",
    lazy = false,
    config = function()
      local gen_ai_spec = require("mini.extra").gen_ai_spec

      require("mini.ai").setup({
        -- n_lines = 1000,
        search_method = "cover_or_next",

        custom_textobjects = {
          B = gen_ai_spec.buffer(),
          D = gen_ai_spec.diagnostic(),
          I = gen_ai_spec.indent(),
          L = gen_ai_spec.line(),
          N = gen_ai_spec.number(),
          J = { { "()%d%d%d%d%-%d%d%-%d%d()", "()%d%d%d%d%/%d%d%/%d%d()" } },
        },
      })
    end,
  },
  {
    "echasnovski/mini.operators",
    lazy = false,
    config = function() require("mini.operators").setup() end,
  },
  {
    "echasnovski/mini.pairs",
    lazy = false,
    config = function()
      require("mini.pairs").setup({
        n_lines = 1000,
        search_method = "cover_or_next",
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    lazy = false,
    config = function()
      require("mini.surround").setup({
        n_lines = 1000,
        search_method = "cover_or_next",
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter", lazy = true },
  { "tyru/operator-camelize.vim", lazy = true },
  { "simeji/winresizer", event = "VeryLazy" },
  { "tpope/vim-repeat", lazy = false },
  { "tpope/vim-commentary", lazy = true },
  { "machakann/vim-highlightedyank", event = "VeryLazy" },
  { "dhruvasagar/vim-table-mode", lazy = true },
  { "vim-denops/denops.vim", lazy = true },
  { "lambdalisue/kensaku.vim", event = "CmdlineEnter" },
  {
    "lambdalisue/kensaku-search.vim",
    lazy = true,
    config = function() vim.api.nvim_set_keymap("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", { noremap = true, silent = true }) end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    config = function()
      require("fzf-lua").setup({
        keymap = {
          fzf = {
            ["ctrl-n"] = "select-all+accept",
          },
        },
        files = {
          rg_opts = [[--color=never --hidden --files -g "!.git"]],
          fd_opts = [[--color=never --hidden --type f --type l --exclude .git]],
          hidden = true,
        },
        grep = {
          rg_opts = [[--column --line-number --no-heading --color=never --smart-case --hidden -g "!.git"]],
          hidden = true,
        },
      })
    end,
    keys = {
      { "<leader>'", ":FzfLua files<cr>", silent = true },
      { "<leader>i", ":FzfLua live_grep<cr>", silent = true },
      { "<leader>b", ":FzfLua buffers<cr>", silent = true },
      { "<leader>g", ":FzfLua git_status<cr>", silent = true },
      { "<leader>m", ":FzfLua marks<cr>", silent = true },
    },
  },
  {
    "0xAdk/full_visual_line.nvim",
    lazy = false,
    config = function() require("full_visual_line").setup({}) end,
  },
  {
    "chrisbra/csv.vim",
    lazy = true,
    config = function() vim.g.csv_default_delim = "," end,
  },
  {
    "monaqa/dial.nvim",
    lazy = true,
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.constant.alias.ja_weekday,
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
        },
      })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual("visual"), { noremap = true })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual("visual"), { noremap = true })
    end,
  },
  { "shaunsingh/nord.nvim", lazy = false },
  {
    "yumafuu/oat.nvim",
    config = function()
      require("oat").setup({
        operators = {
          p = {
            name = "gpt",
            interactive = true,
            command = function(text)
              local encoded_text = vim.fn.substitute(text, " ", "%20", "g")
              local url = "https://chat.com/?q=" .. encoded_text
              return "open " .. vim.fn.shellescape(url)
            end,
            description = "Chat with GPT",
          },
        },
      })
    end,
  },
  {
    "xiyaowong/nvim-transparent",
    lazy = false, -- needed
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = true,
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", { silent = true })
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", { silent = true })
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 100,
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  { "mattn/vim-goimports", lazy = true },
  {
    "ray-x/go.nvim",
    config = function()
      require("go").setup()
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function() require("go.format").goimports() end,
        group = format_sync_grp,
      })
    end,
    event = "VeryLazy",
    ft = { "go", "gomod" },
    build = ':abc require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  { "ray-x/guihua.lua", lazy = true },
  { "b0o/schemastore.nvim", lazy = true },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettierd,
          require("null-ls").builtins.formatting.stylua,
          require("null-ls").builtins.diagnostics.eslint_d,
          require("null-ls").builtins.diagnostics.flake8,
          require("null-ls").builtins.diagnostics.shellcheck,
          require("null-ls").builtins.code_actions.gitsigns,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- TypeScript/JavaScript LSP setup with Deno/Node detection
      local function is_deno_project(fname)
        local root = vim.fs.root(fname, { "deno.json", "deno.jsonc", "deno.lock" })
        if root then return true end

        -- Check shebang for deno
        local file = io.open(fname, "r")
        if file then
          local first_line = file:read("*line")
          file:close()
          if first_line and (first_line:match("#!/usr/bin/env.*deno") or first_line:match("#!/usr/bin/env %-S deno")) then return true end
        end
        return false
      end

      local function is_node_project(fname) return vim.fs.root(fname, { "package.json", "node_modules" }) ~= nil end

      if vim.fn.executable("terraform-ls") == 1 then
        lspconfig.terraformls.setup({
          capabilities = capabilities,
          filetypes = {
            "terraform",
            "tf",
          },
        })
      end

      -- Only setup jsonls if the executable exists
      if vim.fn.executable("vscode-json-language-server") == 1 then
        lspconfig.jsonls.setup({
          capabilities = capabilities,
          cmd = { "vscode-json-language-server", "--stdio" },
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        })
      end

      if vim.fn.executable("deno") == 1 then
        lspconfig.denols.setup({
          capabilities = capabilities,
          root_dir = function(fname)
            if is_deno_project(fname) then return util.root_pattern("deno.json", "deno.jsonc", "deno.lock")(fname) or vim.fs.dirname(fname) end
            return nil
          end,
          init_options = {
            lint = true,
            unstable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.nest.land"] = true,
                  ["https://crux.land"] = true,
                },
              },
            },
          },
        })
      end

      if vim.fn.executable("typescript-language-server") == 1 then
        lspconfig.ts_ls.setup({
          capabilities = capabilities,
          root_dir = function(fname)
            if is_node_project(fname) and not is_deno_project(fname) then return util.root_pattern("package.json")(fname) end
            return nil
          end,
        })
      end

      if vim.fn.executable("typos-lsp") == 1 then
        lspconfig.typos_lsp.setup({
          capabilities = capabilities,
          init_options = {
            config = "~/dotfiles/typos/typos.toml",
          },
          on_attach = function(client, bufnr)
            local name = vim.api.nvim_buf_get_name(bufnr)
            if name:match("^oil://") then
              client.stop()
              return
            end
          end,
        })
      end

      if vim.fn.executable("buf") == 1 then lspconfig.buf_ls.setup({
        capabilities = capabilities,
      }) end

      if vim.fn.executable("gopls") == 1 then
        lspconfig.gopls.setup({
          capabilities = capabilities,
          settings = {
            gopls = {},
          },
          filetypes = {
            "go",
            "gomod",
            "gowork",
          },
        })
      end
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local function is_deno_project(fname)
        local root = vim.fs.root(fname, { "deno.json", "deno.jsonc", "deno.lock" })
        if root then return true end

        -- Check shebang for deno
        local file = io.open(fname, "r")
        if file then
          local first_line = file:read("*line")
          file:close()
          if first_line and (first_line:match("#!/usr/bin/env.*deno") or first_line:match("#!/usr/bin/env %-S deno")) then return true end
        end
        return false
      end

      local function is_node_project(fname) return vim.fs.root(fname, { "package.json", "node_modules" }) ~= nil end

      require("typescript-tools").setup({
        root_dir = function(fname)
          if is_node_project(fname) and not is_deno_project(fname) then return vim.fs.root(fname, { "package.json" }) end
          return nil
        end,
        settings = {
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jsonls", "lua_ls", "gopls", "ts_ls", "denols", "terraformls", "typos_lsp", "buf_ls" },
        automatic_installation = true,
        handlers = {
          -- Default handler for servers without custom config
          function(server_name)
            if
              server_name ~= "jsonls"
              and server_name ~= "denols"
              and server_name ~= "ts_ls"
              and server_name ~= "terraformls"
              and server_name ~= "typos_lsp"
              and server_name ~= "buf_ls"
              and server_name ~= "gopls"
            then
              require("lspconfig")[server_name].setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
              })
            end
          end,
        },
      })

      -- vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>")
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      vim.keymap.set("n", "lga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
      vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
      -- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      vim.keymap.set("n", "ga", "<cmd>lua vim.diagnostic.open_float()<CR>")
      vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
      vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
      vim.api.nvim_set_keymap("n", "<CR>", "<CR>:cclose<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "j-hui/fidget.nvim",
    -- event = "VeryLazy",
    config = function()
      require("fidget").setup({
        notification = {
          window = {
            border = "rounded",
            winblend = 0,
          },
        },
      })
    end,
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          require("hover.providers.diagnostic")
          require("hover.providers.gh")
          require("hover.providers.gh_user")
          require("hover.providers.jira")
          -- require('hover.providers.dap')
          require("hover.providers.fold_preview")
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
          -- require('hover.providers.highlight')
        end,
        preview_opts = {
          border = "rounded",
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          "LSP",
        },
        mouse_delay = 1000,
      })

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
      vim.keymap.set("n", "<S-h>", function() require("hover").hover_switch("previous") end, { desc = "hover.nvim (previous source)" })
      vim.keymap.set("n", "<S-l>", function() require("hover").hover_switch("next") end, { desc = "hover.nvim (next source)" })
      vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })

      vim.o.mousemoveevent = true
    end,
  },
  {
    "greggh/claude-code.nvim",
    config = function() require("claude-code").setup() end,
  },
  -------------------
  -- cmp
  -------------------
  { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
  { "hrsh7th/cmp-buffer", event = "VeryLazy" },
  { "hrsh7th/cmp-path", event = "VeryLazy" },
  { "hrsh7th/cmp-cmdline", event = "VeryLazy" },
  { "hrsh7th/cmp-omni", event = "VeryLazy" },
  { "hrsh7th/cmp-calc", event = "VeryLazy" },
  { "lukas-reineke/cmp-rg", event = "VeryLazy" },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded", -- "shadow" , "none", "rounded"
        -- width = 100,
      })
      local cmp = require("cmp")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            documentation = {
              border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = "codeium" },
          { name = "buffer", max_item_count = 10, keyword_length = 2 },
          { name = "path" },
          { name = "calc" },
          {
            name = "rg",
            keyword_length = 5,
            max_item_count = 5,
            option = { additional_arguments = "--smart-case --hidden" },
            priority = 80,
            group_index = 3,
          },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      -- Set up lspconfig.
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      -- require('lspconfig')['gopls'].setup {
      -- capabilities = capabilities
      -- }
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          style = {
            { fg = "#39AEEE" },
            { fg = "#1045FF" },
          },
          exclude_filetypes = {
            oil = true,
            conf = true,
          },
        },
        line_num = {
          style = "#A4B0C2",
        },
        blank = {
          enabled = true,
        },
      })
    end,
  },
  {
    "Wansmer/treesj",
    lazy = true,
    keys = { "<space>m", "<space>j", "<space>s" },
    config = function() require("treesj").setup() end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterGreen",
          "RainbowDelimiterOrange",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
          "RainbowDelimiterRed",
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    init = function() require("gitsigns").setup() end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    lazy = true,
    init = function()
      require("hlslens").setup()
      vim.cmd([[
        hi default link HlSearchNear IncSearch
        hi default link HlSearchLens WildMenu
        hi default link HlSearchLensNear IncSearch
      ]])
    end,
  },
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    config = function()
      vim.o.showtabline = 2
      vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

      local theme = {
        fill = { fg = "#3A3A3A", bg = "None" },
        current_tab = { fg = "#7BAFDA", bg = "None" },
        tab = { fg = "#595959", bg = "None" },
      }
      local separator = { "│", hl = { fg = "#3A3A3A", bg = "None" }, margin = " " }

      require("tabby").setup({
        line = function(line)
          return {
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep(separator, hl, theme.fill),
                tab.number(),
                tab.name(),
                {
                  " ",
                  hl = hl,
                  margin = " ",
                },
                hl = hl,
                margin = " ",
              }
            end),
            hl = theme.fill,
          }
        end,
      })
    end,
  },
  { "lambdalisue/guise.vim", lazy = true },
  {
    "linrongbin16/gitlinker.nvim",
    lazy = true,
    cmd = "GitLink remote=upstream",
    opts = {
      remote = "git@github.com:knowledge-work/knowledgework.git",
    },
    keys = {
      { "gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  {
    "b0o/incline.nvim",
    lazy = true,
    config = function()
      -- local helpers = require("incline.helpers")
      -- local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

          if filename == "" then filename = vim.bo[props.buf] end

          -- local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            -- ft_icon and { '} ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#3A3A3A",
          }
        end,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      vim.notify = require("notify")
      vim.opt.termguicolors = true

      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  },
  {
    "rebelot/heirline.nvim",
    lazy = true,
    config = function()
      -- local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local Spacer = { provider = " " }

      local function rpad(child)
        return {
          condition = child.condition,
          child,
          Spacer,
        }
      end
      local function OverseerTasksForStatus(status)
        return {
          condition = function(self) return self.tasks[status] end,
          provider = function(self) return string.format("%s%d", self.symbols[status], #self.tasks[status]) end,
          hl = function()
            return {
              fg = utils.get_highlight(string.format("Overseer%s", status)).fg,
            }
          end,
        }
      end

      local Overseer = {
        condition = function() return package.loaded.overseer end,
        init = function(self)
          local tasks = require("overseer.task_list").list_tasks({ unique = true })
          local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
          self.tasks = tasks_by_status
        end,
        static = {
          symbols = {
            ["CANCELED"] = " ",
            ["FAILURE"] = "󰅚 ",
            ["SUCCESS"] = "󰄴 ",
            ["RUNNING"] = "󰑮 ",
          },
        },

        rpad(OverseerTasksForStatus("CANCELED")),
        rpad(OverseerTasksForStatus("RUNNING")),
        rpad(OverseerTasksForStatus("SUCCESS")),
        rpad(OverseerTasksForStatus("FAILURE")),
      }

      require("heirline").setup({
        statusline = { -- FileName
          Overseer,
          Spacer,
          {
            hl = { fg = "#D0D0D0", bg = "none" },
            provider = function()
              local name = vim.fn.bufname()
              return string.gsub(name, "oil://", "")
            end,
          },
        },
      })
    end,
  },
}
