return {
    {
        "williamboman/mason.nvim",
        opts = {},
        keys = {
            { "<leader>M", "<Cmd>Mason<CR>", desc = "Mason", mode = "n" },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "css-lsp",
                "html-lsp",
                "json-lsp",
                "lua-language-server",
                "marksman",
                "phpactor",
                "stylua",
                "taplo",
                "yaml-language-server",
            },
        },
    },
}
