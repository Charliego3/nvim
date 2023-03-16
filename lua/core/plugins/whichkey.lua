local M = {}

local opts = {
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = false, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = 'Comments' },
	-- key_labels = {
	-- override the label used to display some keys. It doesn't effect WK in any other way.
	-- For example:
	-- ['<space>'] = 'SPC',
	-- ['<cr>'] = 'RET',
	-- ['<tab>'] = 'TAB',
	-- },
	motions = {
		count = true,
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "double", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
	show_help = true, -- show a help message in the command line for using WhichKey
	show_keys = false, -- show the currently pressed key and its label as a message in the command line
	triggers = "auto", -- automatically setup triggers
	-- triggers = { '<leader>' }, -- or specifiy a list manually
	-- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
	-- triggers_nowait = {
	-- marks
	--    '`',
	--    ''',
	--    'g`',
	--    'g'',
	-- registers
	--    ''',
	--    '<c-r>',
	-- spelling
	--    'z=',
	-- },
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for keymaps that start with a native binding
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	-- disable = {
	--    buftypes = {},
	--    filetypes = {},
	-- },
}

local nopts = {
	mode = "n", -- NORMAL node
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local nmappings = {
	-- [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["q"] = { "<cmd>:q<CR>", "Quit" },
	["e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
	["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle" },
	t = {
		name = "NvimTree",
		C = { "<cmd>NvimTreeClose<CR>", "Close NvimTree" },
		o = { "<cmd>NvimTreeOpen<CR>", "Open NvimTree" },
		f = { "<cmd>NvimTreeFocus<CR>", "Focus NvimTree" },
		r = { "<cmd>NvimTreeRefresh<CR>", "Refresh NvimTree" },
		c = { "<cmd>NvimTreeClipboard<CR>", "Copy to clipboard" },
		h = { "<cmd>NvimTreeResize -20<CR>", "Zoom NvimTree width" },
		l = { "<cmd>NvimTreeResize 20<CR>", "Enlarge NvimTree width" },
	},
	f = {
		name = "File",
		w = { "<cmd>w!<CR>", "Save" },
		f = { "<cmd>Telescope find_files<CR>", "Find files" },
	},
	c = {
		name = "Code",
		f = {
			function()
				vim.lsp.buf.format()
				vim.api.nvim_command("w")
			end,
			"Format Buffer",
		},
		a = {
			"<cmd>lua vim.lsp.buf.code_action()<CR>",
			"Code Actions",
		},
	},
	b = {
		name = "Buffers",
		j = { "<cmd>BufferLinePick<CR>", "Jump Line Pick" },
		f = { "<cmd>Telescope buffers<CR>", "Find" },
		b = { "<cmd>BufferLineCyclePrev<CR>", "Previous" },
		n = { "<cmd>BufferLineCycleNext<CR>", "Next" },
		e = { "<cmd>BufferLinePickClose<CR>", "Pick which buffer to close" },
		h = { "<cmd>BufferLineCloseLeft<CR>", "Close all to the left" },
		l = { "<cmd>BufferLineCloseRight<CR>", "Close all to the right" },
		d = { "<cmd>BufferLineSortByDirectory<CR>", "Sort by directory" },
		-- l = { '<cmd>BufferLineSortByExtension<CR>', 'Sort by language' },
	},
	g = {
		name = "Git",
		g = { "<cmd>lua require 'core.plugins.terminal'.lazygit_toggle()<CR>", "Lazygit" },
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		s = { "<cmd>Telescope grep_string<cr>", "Grep Text" },
		t = { "<cmd>Telescope live_grep<cr>", "Live Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		p = {
			'<cmd>lua require("telescope.builtin").colorscheme({enable_preview = true})<cr>',
			"Colorscheme with Preview",
		},
	},
}

local vopts = {
	mode = "v",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	normap = true,
	nowait = true,
}

local vmappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle" },
}

M.setup = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 500
	local wk = require("which-key")
	wk.setup(opts)
	wk.register(nmappings, nopts)
	wk.register(vmappings, vopts)
end

return M
