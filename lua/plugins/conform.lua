return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            php = { "php_cs_fixer" },
        },
    },
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
