vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/folke/lazydev.nvim",
}, { confirm = false })

require("mason").setup()
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "~/.local/share/lua/factorio/",
    },
})

vim.diagnostic.config({
    virtual_text = { current_line = true, source = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP functionality",
    group = vim.api.nvim_create_augroup("lsp-attach", {}),
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { desc = "Rename" })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
        vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover documentation" })
        vim.keymap.set("n", "<leader>lH", vim.lsp.buf.signature_help, { desc = "Signature help" })
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "List references" })
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { desc = "List document symbols" })
        vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol,{ desc = "List workspace symbols" })
        if client and client:supports_method("textDocument/inlayHint") then
            vim.keymap.set("n", "<leader>l<Tab>", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end, { desc = "Toggle inlay hints" })
        end
    end,
})

vim.keymap.set("n", "<leader>M", "<Cmd>Mason<CR>", { desc = "Mason" })

local installed_lsp_names = vim.iter(require("mason-registry").get_installed_packages()):fold({}, function(acc, pack)
    table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
    return acc
end)

vim.lsp.enable(installed_lsp_names)
