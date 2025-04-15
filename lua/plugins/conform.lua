return {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    init = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Format on save",
            callback = function()
                require("conform").format({ async = false, lsp_fallback = true })
            end,
        })
    end,
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            php = { "php_cs_fixer" },
        },
    },
    event = { "VeryLazy" },
    keys = {
        {
            "<leader>F",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            desc = "Format buffer",
            mode = "n",
        },
    },
}
