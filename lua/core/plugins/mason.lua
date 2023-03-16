local M = {}
-- local datapath = os.getenv('XDG_DATA_HOME') .. '/mason/bin'
-- if not vim.env.PATH:match(datapath) then
--     local string_separator = vim.loop.os_uname().version:match "Windows" and ";" or ":"
--     vim.env.PATH = vim.env.PATH .. string_separator .. datapath
-- end

local opts = {
    ui = {
        border = 'rounded',
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        }
    },
    -- install_root_dir = datapath,
    -- PATH = 'skip',
    pip = {
        install_args = {},
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    }
}

M.setup = function()
    require("mason").setup(opts)
end

return M
