vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help in vertical split",
    group = vim.api.nvim_create_augroup("vertical-help", { clear = true }),
    pattern = "help",
    callback = function()
        vim.bo.bufhidden = "unload"
        vim.bo.buflisted = true
        vim.cmd.wincmd("L")
        vim.cmd.wincmd("=")
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP functionality",
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local wk = require("which-key")
        wk.add({
            { "<leader>l", group = "LSP", icon = { icon = "", color = "cyan" } },
            { "<leader>lR", vim.lsp.buf.rename, desc = "Rename", icon = { icon = "󰤌", color = "orange" } },
            { "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
            { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to declaration", icon = { icon = "" } },
            { "<leader>lh", vim.lsp.buf.hover, desc = "Hover documentation", icon = { icon = "󰆆", color = "cyan" } },
            {
                "<leader>lH",
                vim.lsp.buf.signature_help,
                desc = "Signature help",
                icon = { icon = "󰆅", color = "cyan" },
            },
            { "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition", icon = { icon = "" } },
            { "<leader>lr", vim.lsp.buf.references, desc = "List references", icon = { icon = "󱉯" } },
            { "<leader>li", vim.lsp.buf.implementation, desc = "Go to implementation", icon = { icon = "" } },
            { "<leader>lt", vim.lsp.buf.type_definition, desc = "Go to type definition", icon = { icon = "" } },
            { "<leader>ls", vim.lsp.buf.document_symbol, desc = "List document symbols", icon = { icon = "󱉯" } },
            { "<leader>lw", vim.lsp.buf.workspace_symbol, desc = "List workspace symbols", icon = { icon = "󱉯" } },
        })
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
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
    end,
})
