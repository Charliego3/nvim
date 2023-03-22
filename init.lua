require("core.neovide")

if vim.fn.has("nvim-0.8") ~= 1 then
    vim.notify("Please upgrade your Neovim base installation. Requires v0.8+", vim.log.levels.WARN)
    vim.wait(1000, function()
    end)
    vim.cmd("cquit")
end

local base_dir = vim.env.NVIM_BASE_DIR
    or (function()
        local init_path = debug.getinfo(1, "S").source
        return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
    end)()

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
    vim.opt.rtp:append(base_dir)
end

-- vim.api.nvim_exec([[
--     augroup reload_vimrc
--         autocmd!
--         autocmd BufWritePost $MYVIMRC lua package.loaded['$MYVIMRC'] = nil; required('$MYVIMRC')
--     augroup end
-- ]], false)

-- vim.notify(base_dir, vim.log.levels.WARN)
-- vim.notify(vim.fn.stdpath("data"), vim.log.levels.WARN)

require("core").setup()
require("core.plugins")

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname == "NoName" then
            vim.cmd("close")
        end
    end,
})
