local lsp = require("lsp-zero")
local icons = require("core.icons")

lsp.preset({
    name = "recommended",
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    manage_luasnip = true,
    call_servers = "local",
    sign_icons = {
        error = icons.diagnostics.BoldError,
        warn = icons.diagnostics.BoldWarning,
        hint = icons.diagnostics.BoldHint,
        info = icons.diagnostics.BoldInformation,
    },
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

lsp.nvim_workspace() -- (Optional) Configure lua language server for neovim
lsp.setup()

local lspconfig = require("lspconfig")
local masonlsp = require("mason-lspconfig")
require("core.plugins.mason")
require("core.plugins.luasnip")
require("core.plugins.cmp")

masonlsp.setup()
masonlsp.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({})
    end,
})
