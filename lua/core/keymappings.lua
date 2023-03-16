local opts = { noremap = true, silent = true }

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- navigation
vim.keymap.set("i", "<A-Up>", "<C-\\><C-N><C-w>k", opts)
vim.keymap.set("i", "<A-Down>", "<C-\\><C-N><C-w>j", opts)
vim.keymap.set("i", "<A-Left>", "<C-\\><C-N><C-w>h", opts)
vim.keymap.set("i", "<A-Right>", "<C-\\><C-N><C-w>l", opts)

-- Better window movement
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
-- Resize with arrows
vim.keymap.set("n", "<A-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<A-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", opts)
-- copy & paste
vim.keymap.set("n", "<C-c>", "vy", opts)
vim.keymap.set("n", "<C-v>", "p", opts)
-- Move current line / block with Alt-j/k a la vscode.
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "]q", ":cnext<CR>", opts)
vim.keymap.set("n", "[q", ":cprev<CR>", opts)
vim.keymap.set("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)
-- navigation on nomal mode
vim.keymap.set("n", "<", "v<gv", opts)
vim.keymap.set("n", ">", "v>gv", opts)

-- Terminal window navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- Better indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts)
-- vim.keymap.set('v', 'p', '"0p', opts)
-- vim.keymap.set('v', 'P', '"0P', opts)
-- visual mode copy & paste
vim.keymap.set("v", "<C-c>", "y", opts)
vim.keymap.set("v", "<C-v>", "p", opts)

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- navigate tab completion with <c-j> and <c-k>
opts = vim.tbl_extend("force", opts, { expr = true, noremap = true })
vim.keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', opts)
vim.keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', opts)
