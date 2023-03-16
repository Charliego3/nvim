local icons = require("core.icons")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	auto_reload_on_write = false,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	hijack_directories = {
		enable = false,
	},
	update_cwd = false, -- update
	view = {
		width = 50,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	renderer = {
		group_empty = false,
		add_trailing = true,
		highlight_git = true,
		highlight_opened_files = "all",
		highlight_modified = "all",
		indent_width = 2,
		root_folder_label = ":~:s?$?/..?",
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "╰─",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "after",
			modified_placement = "after",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
			},
			glyphs = {
				default = icons.ui.Text,
				symlink = icons.ui.FileSymlink,
				bookmark = icons.ui.BookMark,
				modified = "●",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = icons.git.FileUnstaged,
					staged = "✓",
					unmerged = icons.git.FileUnmerged,
					renamed = icons.git.FileRenamed,
					untracked = icons.git.FileUntracked,
					deleted = icons.git.FileDeleted,
					ignored = icons.git.FileIgnored,
				},
			},
		},
	},
	filters = {
		dotfiles = false,
		exclude = { ".DS_Store" },
		git_clean = false,
		no_buffer = false,
		custom = { ".DS_Store" },
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
		update_root = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = icons.diagnostics.BoldHint,
			info = icons.diagnostics.BoldInformation,
			warning = icons.diagnostics.BoldWarning,
			error = icons.diagnostics.BoldError,
		},
	},
	git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		show_on_open_dirs = false,
	},
	modified = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		--[[ expand_all = {
                max_folder_discovery = 300,
                exclude = {},
            }, ]]
		file_popup = {
			open_win_config = {
				col = 1,
				row = 1,
				relative = "cursor",
				border = "shadow",
				-- style = 'minimal',
			},
		},
		open_file = {
			quit_on_open = true,
			resize_window = false,
			window_picker = {
				enable = true,
				picker = "default",
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
		remove_file = {
			close_window = true,
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
		},
	},
	live_filter = {
		prefix = "[FILTER]:",
		always_show_folders = true,
	},
})
-- vim.api.nvim_create_autocmd("BufEnter", {
--     nested = true,
--     callback = function()
--         if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
--             vim.cmd "quit"
--         end
--     end
-- })
--local function open_nvim_tree()
--    require("nvim-tree.api").tree.open()
--end
--vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

--[[ local api = require('nvim-tree.api')
    local events = api.events.Event
    api.events.subscribe(events.NodeRenamed, function (data)
        vim.notify('File renamed from ' .. data.old_name .. ' to ' .. data.new_name, vim.log.levels.INFO, { title = 'File was renamed' })
    end)
    api.events.subscribe(events.FileCreated, function (data)
        vim.notify('File created: ' .. data.fname, vim.log.levels.INFO, { title = 'File was created' })
    end) ]]
vim.cmd("highlight NvimTreeFolderIcon guifg=#DFAF67")
vim.cmd("highlight NvimTreeOpenedFolderIcon guifg=#61DEAF")

local open_nvim_tree = function(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
