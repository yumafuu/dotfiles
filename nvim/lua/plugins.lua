return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      behaviour = {
        auto_suggestions = true,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = true,
        support_paste_from_clipboard = true,
      },
      mappings = {
        ask = "<space>a", -- ask
        edit = "<space>e", -- edit
        refresh = "<space>r", -- refresh
      },
      windows = {
          position = "right",
          width = 30,
          sidebar_header = {
              align = "center",
              rounded = false,
          },
          ask = {
              floating = true,
              start_insert = true,
              border = "rounded"
          }
      },
      copilot = {
        model = "gpt-4o-2024-05-13",
        -- model = "gpt-4o-mini",
        max_tokens = 4096,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "zbirenbaum/copilot.lua",
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
            open = "<M-CR>"
          },
          layout = {
            position = "right", -- | top | left | right | horizontal | vertical
            ratio = 0.3
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
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      tc = require("todo-comments")
      tc.setup({
        search = {
          command = "rg",
          pattern = "MEMO\\(yuma\\)|TODO\\(yuma\\)",
        }
      })

      vim.keymap.set("n", "]t", function() tc.jump_next() end)
      vim.keymap.set("n", "[t", function() tc.jump_prev() end)
    end
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,      -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "fredrikaverpil/neotest-golang", version = "*" },
      { "nvim-neotest/neotest-plenary", version = "*" },
    },
    config = function()
       require("neotest").setup({
        adapters = {
          require("neotest-golang"), -- Registration
          require("neotest-plenary"),
        },
      })
    end,
    keys = {
       {
        "<leader>td",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Debug nearest test",
      },
    },
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  "nvim-lua/popup.nvim",
  "MunifTanjim/nui.nvim",
  "RRethy/vim-illuminate",
  "norcalli/nvim-colorizer.lua",
  {
    "diegoulloao/nvim-file-location",
    config = function()
      require("nvim-file-location").setup({
        keymap = "<leader>cf",
        mode = "workdir", -- options: workdir | absolute
        add_line = false,
        add_column = false,
        default_register = "*",
      })
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "kjuq/sixelview.nvim",
    opts = {},
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}, -- your configuration
  },
  {
    "TobinPalmer/rayso.nvim",
    cmd = { "Rayso" },
    config = function()
      require("rayso").setup({
        open_cmd = "open-via-lemonade",
      })
    end,
  },
  {
    "rapan931/lasterisk.nvim",
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
    tag = "v1.1.0",
    config = function()
      require("insx.preset.standard").setup()
    end,
  },
  "kana/vim-operator-user",
  {
    "kana/vim-operator-replace",
    dependencies = { "kana/vim-operator-user" },
  },
  {
    "tyru/operator-camelize.vim",
    dependencies = { "kana/vim-operator-user" },
  },
  "kana/vim-textobj-user",
  {
    "rhysd/vim-textobj-ruby",
    dependencies = { "kana/vim-textobj-user" },
  },
  "simeji/winresizer",
  -- "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-commentary",
  "machakann/vim-highlightedyank",
  "dhruvasagar/vim-table-mode",
  "nvim-treesitter/nvim-treesitter",
  "vim-denops/denops.vim",
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set("n", "<C-n>", "<Plug>(leap)")
    end,
  },
  {
    "atusy/leap-search.nvim",
    config = function()
      vim.keymap.set("n", "g/", function()
        require("leap-search").leap(vim.fn.getreg("/"))
      end)
    end,
  },
  "lambdalisue/kensaku.vim",
  {
    "lambdalisue/kensaku-search.vim",
    config = function()
      vim.api.nvim_set_keymap("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
      { "<leader>t", ":TodoFzfLua <cr>", silent = true },
    },
  },
  { "kiran94/s3edit.nvim", config = true, cmd = "S3Edit" },
  {
    "0xAdk/full_visual_line.nvim",
    config = function()
      require("full_visual_line").setup({})
    end,
  },
  {
    "chrisbra/csv.vim",
    config = function()
      vim.g.csv_default_delim = ","
    end,
  },
  {
    "akinsho/toggleterm.nvim",
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

      -- Lazysql
      local lazysql = Terminal:new({
        cmd = "lazysql",
        dir = "git_dir",
        direction = "float",
        hidden = true,
        close_on_exit = true,
        highlights = highlights,
        float_opts = float_opts,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<space>s", "<CMD>close<CR>", opts)
        end,
      })
      function _toggleLazysqlTerminal()
        lazysql:toggle()
      end
      vim.api.nvim_set_keymap("n", "<space>s", "<cmd>lua _toggleLazysqlTerminal()<CR>", opts)
    end,
  },
  {
    "monaqa/dial.nvim",
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
  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.cmd("colorscheme nord")
    end,
  },
  -- {
  --   "rmehri01/onenord.nvim",
  --   config = function()
  --     vim.cmd("colorscheme onenord")
  --   end,
  -- },
  {
    "stevearc/oil.nvim",
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
        columns = {
          -- "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
      })

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.keymap.set("n", "<leader>f", ':execute ":e" expand("%:h")<CR>', { noremap = true, silent = true })
    end,
  },
  { "tyru/open-browser.vim" },
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", { silent = true })
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", { silent = true })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  "mattn/vim-goimports",
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "neovim/nvim-lspconfig",
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
          config = '~/dotfiles/typos/typos.toml',
        }
      })
      lspconfig.protols.setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local nvim_lsp = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = {}
          opts.on_attach = function(_, bufnr)
            local bufopts = { silent = true, buffer = bufnr }
          end
          nvim_lsp[server_name].setup(opts)
        end,
      })
      vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>")
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
      vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.code_action()<CR>")
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
      vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
      vim.keymap.set("n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>")
      vim.keymap.set("n", "ga", "<cmd>lua vim.diagnostic.open_float()<CR>")
      vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
      vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        float = { border = "rounded" },
      })
    end,
  },
  -------------------
  -- cmp
  -------------------
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded", -- "shadow" , "none", "rounded"
        -- border = border
        -- width = 100,
      })
      local cmp = require("cmp")

      cmp.setup({
        -- snippet = {
        --   -- REQUIRED - you must specify a snippet engine
        --   expand = function(args)
        --     -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        --     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        --     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        --     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        --     -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        --   end,
        -- },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
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
          -- { name = "vsnip" }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = "buffer" },
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
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup()
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
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
    init = function()
      require("gitsigns").setup()
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
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
    -- event = 'VimEnter',
    dependencies = "nvim-tree/nvim-web-devicons",
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
  { "sindrets/diffview.nvim" },
  { "lambdalisue/guise.vim" },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  {
    "b0o/incline.nvim",
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
    "YumaFuu/translate.nvim",
    dependencies = { "niuiic/core.nvim" },
    config = function()
      require("translate").setup({
        output = {
          float = {
            max_width = 70,
            max_height = 10,
            close_on_cursor_move = true,
            enter_key = "T",
          },
        },
        translate = {
          {
            -- use :Trans start this job
            cmd = "Trans",
            command = "trans",
            args = function(trans_source)
              -- trans_source is the text you want to translate
              return {
                "-b",
                -- "-e",
                -- "google",
                -- use proxy
                -- "-x",
                -- "http://127.0.0.1:10025",
                "-t",
                "ja",
                -- you can filter translate source here
                trans_source,
              }
            end,
            -- how to get translate source
            -- selection | input | clipboard
            input = "selection",
            -- how to output translate result
            -- float_win | notify | clipboard | insert
            output = { "float_win" },
            -- format output
            ---@type fun(output: string): string
            format = function(output)
              return output
            end,
          },
        },
      })
      vim.keymap.set("v", "<c-t>", "<cmd>Trans<CR>", { silent = true })
      vim.keymap.set("n", "<space>t", "<cmd>Trans<CR>")
    end,
  },
  {
    "rcarriga/nvim-notify",
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
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          layout_strategy = "flex",
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<ecs>"] = require("telescope.actions").close,
              ["<c-j>"] = require("telescope.actions").move_selection_next,
              ["<c-k>"] = require("telescope.actions").move_selection_previous,
              ["<c-w>"] = function()
                -- local actions = require('telescope.actions')
                -- local action_state = require('telescope.actions.state')
                local line = require("telescope.actions.state").get_current_line()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                local new_line = line:sub(cursor_pos[2] + 2)
                vim.api.nvim_feedkeys(new_line, "n", true)
                vim.api.nvim_win_set_cursor(0, { cursor_pos[1], 0 })
              end,
            },
            n = {
              ["<ecs>"] = require("telescope.actions").close,
              ["<c-j>"] = require("telescope.actions").move_selection_next,
              ["<c-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
        },
      })
    end,
  },
}
