local M = {}

-- local datapath = os.getenv('XDG_DATA_HOME')
-- if not vim.tbl_contains(vim.opt.rtp:get(), datapath) then
--     vim.opt.rtp:append(datapath)
-- end

local opts = {
	-- parser_install_dir = datapath,
	ensure_installed = { "go", "java", "lua" },
	sync_install = false,
	ignore_install = {},
	auto_install = false,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			if vim.tbl_contains({ "latex" }, lang) then
				vim.notify("Latex disabled in treesitter", vim.log.levels.WARN, { title = "Treesitter Latex" })
				return true
			end

			local max_filesize = 1024 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				vim.notify(
					"File is large, disable treesitter: " .. max_filesize,
					vim.log.levels.WARN,
					{ title = "Treesitter file large" }
				)
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	textsubjects = {
		enable = true,
		keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
	},
	playground = {
		enable = false,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_line = 1000,
	},
	context_commentstring = {
		enable = true,
        enable_autocmd = false,
	},
}

M.setup = function()
	require("nvim-treesitter.configs").setup(opts)
end

return M
