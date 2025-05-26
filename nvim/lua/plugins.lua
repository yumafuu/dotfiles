return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "Exafunction/windsurf.nvim",
    config = function()
      require("codeium").setup({
        virtual_text = {
          enabled = true,
          manual = false,
          filetypes = {},
          default_filetype_enabled = true,
          idle_delay = 75,
          virtual_text_priority = 65535,
          map_keys = true,
          accept_fallback = nil,
          key_bindings = {
            accept = "<C-g>",
            accept_word = false,
            accept_line = false,
            clear = false,
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken", -- Only on MacOS or Linux
    event = "VeryLazy",
    opts = {
      -- See Configuration section for options
    },
  },
  {
    "olimorris/codecompanion.nvim",
    config = function()
    end,
  },
  -- {
  --   "yetone/avante.nvim",
  --   opts = {
  --     provider = "claude",
  --     claude = {
  --       endpoint = "https://api.anthropic.com",
  --       model = "claude-3-7-sonnet-20250219",
  --     },
  --     vertex = {
  --       model = "gemini-2.5-pro-preview-05-06",
  --       endpoint = "https://us-central1-aiplatform.googleapis.com/v1/projects/kwit-gemini-api/locations/us-central1/publishers/google/models",
  --     },
  --   },
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   system_prompt = function()
  --     local hub = require("mcphub").get_hub_instance()
  --     return hub:get_active_servers_prompt()
  --   end,
  --   -- Using function prevents requiring mcphub before it's loaded
  --   custom_tools = function()
  --     return {
  --       require("mcphub.extensions.avante").mcp_tool(),
  --     }
  --   end,
  -- },
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        auto_approve = false,
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "?", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
  {
    "ysmb-wtsg/in-and-out.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("i", "<C-k>", function()
        require("in-and-out").in_and_out()
      end)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
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
            accept = "<C-g>",
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VimEnter",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  -- {
  --   "github/copilot.vim",
  --   enabled = true,
  --   config = function()
  --     vim.g.copilot_no_tab_map = true

  --     local keymap = vim.keymap.set
  --     -- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
  --     keymap(
  --       "i",
  --       "<C-g>",
  --       'copilot#Accept("<CR>")',
  --       { silent = true, expr = true, script = true, replace_keycodes = false }
  --     )
  --     keymap("i", "<C-j>", "<Plug>(copilot-next)")
  --     keymap("i", "<C-k>", "<Plug>(copilot-previous)")
  --     keymap("i", "<C-o>", "<Plug>(copilot-dismiss)")
  --     keymap("i", "<C-s>", "<Plug>(copilot-suggest)")
  --   end,
  -- },
  {
    "pmizio/typescript-tools.nvim",
    opts = {},
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
          require("quicktest.adapters.vitest")({}),
          require("quicktest.adapters.playwright")({}),
          require("quicktest.adapters.elixir"),
          require("quicktest.adapters.criterion"),
          require("quicktest.adapters.dart"),
          require("quicktest.adapters.rspec"),
        },
        -- split or popup mode, when argument not specified
        default_win_mode = "split",
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
    config = function()
      require("nvim-highlight-colors").setup()
    end,
  },
  {
    "diegoulloao/nvim-file-location",
    event = "VeryLazy",
    config = function()
      require("nvim-file-location").setup({
        keymap = "<leader>l",
        mode = "workdir", -- options: workdir | absolute
        add_line = false,
        add_column = false,
        default_register = "*",
      })
    end,
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
    config = function()
      require("rayso").setup({
        open_cmd = "open-via-lemonade",
      })
    end,
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
    config = function()
      require("insx.preset.standard").setup()
    end,
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
  { "tyru/operator-camelize.vim", lazy = true },
  { "kana/vim-textobj-user", lazy = true },
  { "simeji/winresizer", event = "VeryLazy" },
  { "tpope/vim-repeat", lazy = false },
  { "tpope/vim-commentary", lazy = true },
  { "machakann/vim-highlightedyank", event = "VeryLazy" },
  { "dhruvasagar/vim-table-mode", lazy = true },
  { "nvim-treesitter/nvim-treesitter", lazy = true },
  { "vim-denops/denops.vim", lazy = true },
  { "lambdalisue/kensaku.vim", event = "CmdlineEnter" },
  {
    "lambdalisue/kensaku-search.vim",
    lazy = true,
    config = function()
      vim.api.nvim_set_keymap("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", { noremap = true, silent = true })
    end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
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
    lazy = true,
    config = function()
      require("full_visual_line").setup({})
    end,
  },
  {
    "chrisbra/csv.vim",
    lazy = true,
    config = function()
      vim.g.csv_default_delim = ","
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      local opts = { noremap = true, silent = true }
      local Terminal = require("toggleterm.terminal").Terminal

      local float_opts = {
        border = "curved",
      }
      local highlights = {
        Normal = {
          -- guibg = "#262626",
          guibg = None,
        },
        FloatBorder = {
          guifg = "#3A3A3A",
          -- guibg = "#262626",
          guibg = None,
        },
      }

      -- LazyDocker
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        -- dir = "git_dir",
        direction = "float",
        hidden = true,
        close_on_exit = true,
        float_opts = float_opts,
        highlights = highlights,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Space>d", "<CMD>close<CR>", opts)
        end,
      })
      function _toggleLazydockerTerminal()
        lazydocker:toggle()
      end
      vim.api.nvim_set_keymap("n", "<Space>d", "<cmd>lua _toggleLazydockerTerminal()<CR>", opts)

      -- LazyGit
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        hidden = true,
        close_on_exit = true,
        highlights = highlights,
        float_opts = float_opts,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-\\>", "<CMD>close<CR>", opts)
        end,
      })
      function _toggleLazygitTerminal()
        lazygit:toggle()
      end
      vim.api.nvim_set_keymap("n", "<c-\\>", "<cmd>lua _toggleLazygitTerminal()<CR>", opts)
    end,
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
          add = function(path)
            return false
          end,
          mv = function(src_path, dest_path)
            return false
          end,
          rm = function(path)
            return false
          end,
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
        if dir == "" then
          dir = vim.fn.getcwd()
        end
        vim.cmd("e " .. dir)
      end, { noremap = true, silent = true })
    end,
  },
  { "tyru/open-browser.vim", event = "VeryLazy" },
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
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
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
        callback = function()
         require('go.format').goimports()
        end,
        group = format_sync_grp,
      })

    end,
    event = "VeryLazy",
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  { "ray-x/guihua.lua", lazy = true },
  {
    "neovim/nvim-lspconfig",
    -- lazy = true,
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig["denols"].setup({
        root_dir = lspconfig.util.root_pattern("deno.json"),
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
      lspconfig["ts_ls"].setup({
        root_dir = lspconfig.util.root_pattern("package.json"),
      })
      lspconfig.typos_lsp.setup({
        init_options = {
          config = "~/dotfiles/typos/typos.toml",
        },
      })
      -- lspconfig.protols.setup({})
      lspconfig.buf_ls.setup({})
      -- lspconfig.terraform.setup({})
      lspconfig.terraformls.setup({})
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            ---- Build ----
            directoryFilters = { --{{{
              -- common
              "-**/.git",
              "-**/vendor",
              "-**/.symlinks",
              -- for Node.JS
              "-**/.next",
              "-**/.swc",
              "-**/node_modules",
              "-**/storybook-static",
              "-**/.pnpm-store",
              -- for Python
              "-**/.mypy_cache",
              "-**/__pycache__",
              "-**/.pytest_cache",
              "-**/.venv",
              "-**/venv",
              "-**/.neptune",
              -- for Terraform
              "-**/.terraform",
              -- for Dart and Flutter
              "-**/.dart_tool",
              -- for iOS
              "-**/Pods",
              "-**/.fvm",
              -- for MyProjects
              "-**/.cache",
              "-**/data",
              "-**/results",
              "-**/results_plots",
              "-**/output",
              "-**/.docker-compose-data",
              "-**/coverage",
            }, --}}}
            templateExtensions = {
              ".go.tmpl",
              ".go.tpl",
              ".gotmpl",
              ".gotpl",
            },
            ---- Formatting ----
            ["local"] = os.getenv("GO_IMPORTS_LOCAL"),
            ---- UI ----
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              test = false,
              tidy = true,
              upgrade_dependency = true,
              vendor = false,
            },
            ---- UI Completion ----
            usePlaceholders = true,
            ---- UI Diagnostic ----
            analyses = {
              unusedparams = false,
            },
            ---- UI Documentation ----
            ---- UI Inlayhint ----
            ---- UI Navigation ----
          },
        },
        filetypes = {
          "go",
          "gomod",
          "gowork",
        },
        -- on_attach = function()
        --   fmt_on_save()
        -- end,
      })
      -- lspconfig.golangci_lint_ls.setup({
      --   capabilities = capabilities,
      --   init_options = (function()
      --     local handle = io.popen(
      --       "golangci-lint --version 2>/dev/null | grep -o 'version [0-9]\\+\\.[0-9]\\+\\.[0-9]\\+' | cut -d' ' -f2")
      --     local version = handle and handle:read("*a"):gsub("%s+$", "") or ""
      --     if handle then handle:close() end

      --     local major_version = tonumber(version:match("^(%d+)%."))

      --     if major_version and major_version < 2 then
      --       return {
      --         command = {
      --           "golangci-lint",
      --           "run",
      --           "--out-format",
      --           "json",
      --           "--issues-exit-code=1",
      --         }
      --       }
      --     end

      --     return {}
      --   end)(),
      -- })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    config = function()
      local nvim_lsp = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      -- mason_lspconfig.setup_handlers({
      --   function(server_name)
      --     local opts = {}
      --     opts.on_attach = function(_, bufnr)
      --       local bufopts = { silent = true, buffer = bufnr }
      --     end
      --     nvim_lsp[server_name].setup(opts)
      --   end,
      -- })
      vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>")
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      vim.keymap.set("n", "lca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
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
          require('hover.providers.diagnostic')
          require('hover.providers.gh')
          require('hover.providers.gh_user')
          require('hover.providers.jira')
          -- require('hover.providers.dap')
          require('hover.providers.fold_preview')
          -- require('hover.providers.man')
          require('hover.providers.dictionary')
          -- require('hover.providers.highlight')
        end,
        preview_opts = {
          border = "rounded",
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = true,
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

      vim.o.mousemoveevent = true
    end,
  },
  {
    "greggh/claude-code.nvim",
    config = function()
      require("claude-code").setup()
    end
  },
  -------------------
  -- cmp
  -------------------
  { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
  { "hrsh7th/cmp-buffer", event = "VeryLazy" },
  { "hrsh7th/cmp-path", event = "VeryLazy" },
  { "hrsh7th/cmp-cmdline", event = "VeryLazy" },
  { "hrsh7th/cmp-omni", event = "VeryLazy" },
  { "hrsh7th/cmp-nvim-lsp-signature-help", event = "VeryLazy" },
  { "hrsh7th/cmp-calc", event = "VeryLazy" },
  { "lukas-reineke/cmp-rg", event = "VeryLazy" },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded", -- "shadow" , "none", "rounded"
        border = border,
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
          { name = "codeium" },
          { name = "buffer", max_item_count = 10, keyword_length = 2 },
          { name = "path" },
          { name = "calc" },
          { name = "omni", option = { disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" } } },
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

      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
      --

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
    config = function()
      require("treesj").setup()
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require("rainbow-delimiters")

      ---@type rainbow_delimiters.config
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
        strategy = "toggleterm",

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
    "lewis6991/gitsigns.nvim",
    lazy = true,
    init = function()
      require("gitsigns").setup()
    end,
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
    cmd = "GitLink",
    opts = {},
    keys = {
      { "gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  {
    "b0o/incline.nvim",
    lazy = true,
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

          if filename == "" then
            filename = vim.bo[props.buf]
          end

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
      local conditions = require("heirline.conditions")
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
          condition = function(self)
            return self.tasks[status]
          end,
          provider = function(self)
            return string.format("%s%d", self.symbols[status], #self.tasks[status])
          end,
          hl = function(self)
            return {
              fg = utils.get_highlight(string.format("Overseer%s", status)).fg,
            }
          end,
        }
      end

      local Overseer = {
        condition = function()
          return package.loaded.overseer
        end,
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
