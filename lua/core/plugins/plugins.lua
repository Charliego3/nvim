local plugins = {
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("core.plugins.dashboard")
        end,
        dependencies = {
            { "kyazdani42/nvim-web-devicons" },
        },
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({})
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = require("core.plugins.telescope").setup,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        requires = { "nvim-telescope/telescope.nvim" },
        build = "make",
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = require("core.plugins.treesitter").setup,
    },
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("core.plugins.nvimtree")
        end,
    },
    {
        "folke/which-key.nvim",
        config = require("core.plugins.whichkey").setup,
    },

    -- Lsp Configuration
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },    -- Required
            { "williamboman/mason.nvim" },  -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" },    -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
        config = function()
            require("core.plugins.lsp")
        end,
    },
    {
        "folke/neodev.nvim",
        module = "neodev",
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("core.plugins.nullls")
        end,
    },
    -- pretty list for showing diagnostics, references, telescope results, quickfix and location list
    {
        "folke/trouble.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("core.plugins.trouble")
        end,
    },

    -- Debugging
    --[[ {
		"mfussenegger/nvim-dap",
		-- event = "BufWinEnter",
		config = function()
			require("lvim.core.dap").setup()
		end,
	}, ]]

    -- Debugger user interface
    --[[ {
		"rcarriga/nvim-dap-ui",
		config = function()
			require("lvim.core.dap").setup_ui()
		end,
	}, ]]

    -- Comments
    {
        "numToStr/Comment.nvim",
        event = "BufRead",
        config = function()
            require("core.plugins.comment")
        end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },

    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        event = "BufWinEnter",
        branch = "main",
        config = require("core.plugins.terminal").setup,
    },

    -- Themes
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
        config = function()
            require("core.plugins.lualine")
        end,
    },
    {
        "tiagovla/tokyodark.nvim",
        config = require("core.plugins.themes").setupTokyoDark,
        enabled = require("core.plugins.themes").tokyoDarkEnabled(),
    },
    {
        "folke/tokyonight.nvim",
        config = require("core.plugins.themes").setupTokyoNight,
        enabled = require("core.plugins.themes").tokyoNightEnabled(),
        dependencies = "neovim/nvim-lspconfig",
    },
    {
        "lunarvim/onedarker.nvim",
        branch = "freeze",
        config = require("core.plugins.themes").setupOnedarker,
        enabled = require("core.plugins.themes").onedarkerEnabled(),
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = require("core.plugins.themes").setupCatppuccin,
        enabled = require("core.plugins.themes").catppuccinEnabled(),
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = require("core.plugins.bufferline").setup,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
    { "rcarriga/nvim-notify" },
    { "nvim-lua/popup.nvim" },

    -- Automatically provides suggestions as you type & High level of customisation
    {
        "gelguy/wilder.nvim",
        build = ":UpdateRemotePlugins",
        config = function()
            require("core.plugins.wilder")
        end,
    },
    { "romgrk/fzy-lua-native" },
    { "nixprime/cpsm" },

    -- gitsigns
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("core.plugins.gitsigns")
        end,
        event = "BufRead",
    },

    -- SchemaStore
    {
        "b0o/schemastore.nvim",
    },

    -- project.nvim
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("core.plugins.project")
        end,
    },

    -- automatically highlighting other uses of the word under the cursor
    {
        "RRethy/vim-illuminate",
        config = function()
            require("core.plugins.illuminate")
        end,
    },

    -- adds indentation guides to all lines
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("core.plugins.blankline")
        end,
    },

    -- breadcrumbs
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "kyazdani42/nvim-web-devicons", -- optional dependency
        },
        config = function ()
            require("core.plugins.barbecue")
        end
    },
}

return plugins
