local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local format_on_save = false

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(_, bufnr)
    if not format_on_save then
        return
    end

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
end

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        diagnostics.markdownlint,
        diagnostics.flake8,
    },
    on_attach = on_attach,
})

-- require("lspconfig")["null-ls"].setup()
