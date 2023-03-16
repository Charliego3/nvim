local generic_opts_any = { noremap = true, silent = true }
local defaults = {
    i = {
        keys = {
            -- Move current line / block with Alt-j/k ala vscode.
            ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
            -- Move current line / block with Alt-j/k ala vscode.
            ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
            -- navigation
            ["<A-Up>"] = "<C-\\><C-N><C-w>k",
            ["<A-Down>"] = "<C-\\><C-N><C-w>j",
            ["<A-Left>"] = "<C-\\><C-N><C-w>h",
            ["<A-Right>"] = "<C-\\><C-N><C-w>l",
        },
        opts = generic_opts_any,
    },
    n = {
        keys = {
            -- Better window movement
            ["<C-h>"] = "<C-w>h",
            ["<C-j>"] = "<C-w>j",
            ["<C-k>"] = "<C-w>k",
            ["<C-l>"] = "<C-w>l",
            -- Resize with arrows
            ["<C-Up>"] = ":resize -2<CR>",
            ["<C-Down>"] = ":resize +2<CR>",
            ["<C-Left>"] = ":vertical resize -2<CR>",
            ["<C-Right>"] = ":vertical resize +2<CR>",
            -- Move current line / block with Alt-j/k a la vscode.
            ["<A-j>"] = ":m .+1<CR>==",
            ["<A-k>"] = ":m .-2<CR>==",
            -- QuickFix
            ["]q"] = ":cnext<CR>",
            ["[q"] = ":cprev<CR>",
            ["<C-q>"] = ":call QuickFixToggle()<CR>",
        },
        opts = generic_opts_any,
    },
    t = {
        keys = {
            -- Terminal window navigation
            ["<C-h>"] = "<C-\\><C-N><C-w>h",
            ["<C-j>"] = "<C-\\><C-N><C-w>j",
            ["<C-k>"] = "<C-\\><C-N><C-w>k",
            ["<C-l>"] = "<C-\\><C-N><C-w>l",
        },
        opts = { silent = true },
    },
    v = {
        keys = {
            -- Better indenting
            ["<"] = "<gv",
            [">"] = ">gv",
            -- ["p"] = '"0p',
            -- ["P"] = '"0P',
        },
        opts = generic_opts_any,
    },
    x = {
        keys = {
            -- Move current line / block with Alt-j/k ala vscode.
            ["<A-j>"] = ":m '>+1<CR>gv-gv",
            ["<A-k>"] = ":m '<-2<CR>gv-gv",
        },
        opts = generic_opts_any,
    },
    c = {
        keys = {
            -- navigate tab completion with <c-j> and <c-k>
            -- runs conditionally
            ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
            ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
        },
        opts = generic_opts_any,
    },
}

for mode, mappings in pairs(defaults) do
    vim.notify(mode .. mappings)
    local opts = mappings.opts
    for key, val in pairs(mappings.keys) do
        pcall(vim.api.nvim_del_keymap, mode, key)
        vim.keymap.set(mode, key, val, opts)
    end
end
