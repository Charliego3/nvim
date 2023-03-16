local M = {}
local colors = require("core.colors")
local schema = "tokyonight-night"

M.bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.orange },
        b = { fg = colors.black, bg = colors.cyan },
        c = { fg = colors.white, bg = colors.darkblue },
        x = { fg = colors.white, bg = colors.darkblue },
        y = { fg = colors.black, bg = colors.yellow },
        z = { fg = colors.black, bg = colors.purple },
    },
    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.red } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    },
}

M.setupTokyoDark = function()
    local g = vim.g
    g.tokyodark_transparent_background = false
    g.tokyodark_enable_italic_comment = true
    g.tokyodark_enable_italic = true
    g.tokyodark_color_gamma = "1.0"
    vim.cmd("colorscheme tokyodark")
end

M.tokyoDarkEnabled = function()
    return schema == "tokyodark"
end

M.setupTokyoNight = function()
    require("tokyonight").setup({
        style = "night",
        light_style = "day",
        transparent = false,
        terminal_color = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true, bold = true },
            functions = { italic = true, bold = true },
            variables = {},
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,       -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,       -- dims inactive windows
        lualine_bold = false,       -- When `true`, section headers in the lualine theme will be bold
        -- You can override specific color groups to use other groups or a hex color
        -- function will be called with a ColorScheme table
        -- @param colors ColorScheme
        on_colors = function(colorSchema)
            colorSchema.hint = colorSchema.orange
            colorSchema.error = "#ff0000"
        end,
        -- You can override specific highlights to use other groups or a hex color
        -- function will be called with a Highlights and ColorScheme table
        -- @param highlights Highlights
        -- @param colors ColorScheme
        on_highlights = function(highlights, _)
            highlights.IlluminatedWordText = { style = "underline" }
            highlights.IlluminatedWordRead = { style = "underline" }
            highlights.IlluminatedWordWrite = { style = "underline" }
        end,
    })
    vim.cmd([[
        augroup illuminate_augroup
            autocmd!
            autocmd VimEnter * hi link illuminatedWord CursorLine
        augroup END

        augroup illuminate_augroup
        autocmd!
            autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
        augroup END

        augroup illuminate_augroup
            autocmd!
            autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
        augroup END
    ]])
    vim.cmd("colorscheme tokyonight-night")
end

M.tokyoNightEnabled = function()
    return schema == "tokyonight-night"
end

M.setupOnedarker = function()
    vim.cmd("colorscheme onedarker")
end

M.onedarkerEnabled = function()
    return schema == "onedarker"
end

return M
