return {
    {
        "folke/lazydev.nvim",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
        ft = { "lua" },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        fallbacks = { "lsp" },
                        module = "lazydev.integrations.blink",
                    },
                },
            },
        },
    },
}
