local on_attach = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local wk = require("which-key")
    wk.add({
        { "<leader>l", group = "LSP" },
        { "<leader>lR", vim.lsp.buf.rename, desc = "Rename" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
        { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to declaration" },
        { "<leader>lh", vim.lsp.buf.hover, desc = "Hover documentation" },
        { "<leader>lH", vim.lsp.buf.signature_help, desc = "Signature help" },
        { "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition" },
        { "<leader>lr", vim.lsp.buf.references, desc = "List references" },
        { "<leader>li", vim.lsp.buf.implementation, desc = "Go to implementation" },
        { "<leader>lt", vim.lsp.buf.type_definition, desc = "Go to type definition" },
        { "<leader>ls", vim.lsp.buf.document_symbol, desc = "List document symbols" },
        { "<leader>lw", vim.lsp.buf.workspace_symbol, desc = "List workspace symbols" },
    })
    if client and client:supports_method("textDocument/inlayHint") then
        wk.add({
            {
                "<leader>l<Tab>",
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                end,
                desc = "Toggle inlay hints",
            },
        })
    end
end

local servers = {}

for _, filename in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    servers[#servers + 1] = vim.fn.fnamemodify(filename, ":t:r")
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP functionality",
    group = vim.api.nvim_create_augroup("lsp-attach", {}),
    callback = on_attach,
})

vim.lsp.enable(servers)
