require("dashboard").setup {
    theme = 'hyper',
    shortcut_type = 'number',
    config = {
        week_header = {
            enable = true,
            -- concat = "header concat",
        },
        shortcut = {
            {
                desc = ' Update',
                group = '@property',
                action = 'Lazy update',
                key = 'u',
            },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' apps',
                group = 'diagnostichint',
                action = 'telescope app',
                key = 'a',
            },
            {
                desc = ' dotfiles',
                group = 'number',
                action = 'telescope dotfiles',
                key = 'd',
            },
        },
        project = {
            {
                enable = true,
                limit = 10,
                group = 'DashboardProjectTitleIcon',
                icon_hl = 'DashboardProjectTitleIcon',
                action = 'Telescope find_files cwd=',
            }
        },
        mru = {
            limit = 20,
        },
        footer = {

        }
    },
    hide = {
        statusline = false,
        tabline = true,
        winbar = true,
    },
    preview = {
        file_height = 50,
    }
}
