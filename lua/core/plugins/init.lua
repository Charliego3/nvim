local datapath = vim.fn.stdpath("data")
local lazypath = datapath .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    lockfile = datapath .. '/lazy-lock.json',
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
}

local plugins = require("core.plugins.plugins")
require("lazy").setup(plugins, opts)
require("core.plugins.telescope").setup()
require("core.plugins.lualine")
