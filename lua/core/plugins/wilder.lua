local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			file_command = function(_, arg)
				if string.find(arg, ".") ~= nil then
					return { "fd", "-tf", "-H" }
				else
					return { "fd", "-tf" }
				end
			end,
			-- file_command = { "fd", "-tf" },
			dir_command = { "fd", "-td" },
			filters = { "fuzzy_filter" },
		}),
		wilder.substitute_pipeline({
			pipeline = wilder.python_search_pipeline({
				skip_cmdtype_check = 1,
				pattern = wilder.python_fuzzy_pattern({
					start_at_boundary = 0,
				}),
			}),
		}),
		wilder.cmdline_pipeline({
			fuzzy = 2,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		{
			wilder.check(function(_, x)
				return x == ""
			end),
			wilder.history(),
		},
		wilder.python_search_pipeline({
			pattern = wilder.python_fuzzy_pattern({
				start_at_boundary = 0,
			}),
		})
	),
})

local highlighters = {
	wilder.pcre2_highlighter(),
	wilder.lua_fzy_highlighter(),
}

local border_theme = {
	border = "rounded",
	empty_message = wilder.popupmenu_empty_message_with_spinner(),
	highlighter = highlighters,
	highlights = {
		accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
	},
	left = {
		" ",
		wilder.popupmenu_devicons(),
	},
	right = {
		" ",
		wilder.popupmenu_buffer_flags({
			flags = " a + ",
			icons = { ["+"] = "", a = "", h = "" },
		}),
		wilder.popupmenu_scrollbar(),
	},
}
local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme(border_theme))

local wildmenu_renderer = wilder.wildmenu_renderer({
	highlighter = highlighters,
	separator = " · ",
	left = { " ", wilder.wildmenu_spinner(), " " },
	right = { " ", wilder.wildmenu_index() },
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = popupmenu_renderer,
		["/"] = popupmenu_renderer,
		substitute = wildmenu_renderer,
	})
)

-- local palette_theme = vim.tbl_extend("force", border_theme, {
-- 	-- 'single', 'double', 'rounded' or 'solid'
-- 	-- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
-- 	border = "rounded",
-- 	max_height = "75%", -- max height of the palette
-- 	min_height = 0, -- set to the same as 'max_height' for a fixed height window
-- 	prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
-- 	reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
-- })
-- wilder.set_option("renderer", wilder.popupmenu_renderer(wilder.popupmenu_palette_theme(palette_theme)))
