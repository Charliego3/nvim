local icons = require("core.icons")
local themes = require("core.plugins.themes")
local colors = require("core.colors")

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local hide_in_width = function()
    return vim.o.columns > 100
end

local warp = function (str)
    if str == "" then
        return str
    end
    return '[' .. str .. ']'
end

local opts = {
    options = {
        icons_enable = true,
        theme = themes.bubbles_theme,
        component_separators = { '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "alpha" },
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            {
                "mode",
                icon = icons.ui.Target,
                separator = { left = '', right = '' },
                padding = { left = 0, right = 0 },
            }
        },
        lualine_b = {
            {
                "branch",
                icon = icons.git.Branch,
                separator = { right = '' },
                color = { gui = "bold" },
            },
            --[[ {
                "windows",
                color = { bg = colors.orange, fg = colors.cyan },
                separator = { right = '' },
            }, ]]
            --[[ {
                "tabs",
                color = { bg = colors.orange, fg = colors.cyan },
                separator = { right = '' },
            } ]]
        },
        lualine_c = {
            {
                "filename",
                fmt = warp,
                color = { fg = colors.white, gui = "bold" },
                cond = nil,
                padding = { left = 2, right = 2, }
            },
            {
                "diff",
                source = diff_source,
                symbols = {
                    added = icons.git.LineAdded .. " ",
                    modified = icons.git.LineModified .. " ",
                    removed = icons.git.LineRemoved .. " ",
                },
                padding = { right = 1 },
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.yellow },
                    removed = { fg = colors.red },
                },
                cond = nil,
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = icons.diagnostics.BoldError .. " ",
                    warn = icons.diagnostics.BoldWarning .. " ",
                    info = icons.diagnostics.BoldInformation .. " ",
                    hint = icons.diagnostics.BoldHint .. " ",
                },
                cond = hide_in_width,
                padding = { left = 2, right = 2 },
            },
        },
        lualine_x = {
            -- lsp
            {
                function()
                    local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
                    return icons.ui.Tab .. " " .. shiftwidth
                end,
                fmt = warp,
                padding = { left = 2, right = 1 },
                color = { fg = colors.white, gui = 'bold' }
            },
            {
                "filetype",
                fmt = warp,
                separator = { left = '[', right = ']' },
                padding = { left = 1, right = 1 },
                color = { fg = colors.white, gui = 'bold' },
            },
            {
                "o:encoding",
                fmt = function (str)
                    return warp(string.upper(str))
                end,
                color = { fg = colors.white, gui = 'bold' },
                cond = hide_in_width,
                padding = { left = 1, right = 1 },
            },
            {
                "filesize",
                fmt = warp,
                padding = { left = 1, right = 1 },
            },
            {
                function()
                    return icons.ui.Tree
                end,
                color = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local ts = vim.treesitter.highlighter.active[buf]
                    return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
                end,
                cond = hide_in_width,
                padding = { left = 1, right = 1 },
            },
            {
                "fileformat",
                padding = { left = 1, right = 2 },
            }
        },
        lualine_y ={
            {
                "progress",
            },
        },
        lualine_z = {
            {
                "location",
                separator = { left = '', right = '' },
                padding = { left = 0, right = 0 },
            }
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'diff' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {},
}

require("lualine").setup(opts)
