require("core").setup({
    early = { "config.options" },
    lazy = {
        dev = {
            path = "~/dev/nvim",
            patterns = { "atanvarno69" },
        },
        spec = {
            {
                "atanvarno69/basic.nvim",
                dev = true,
                opts = { lsp = "config.lsp" },
            },
            { import = "plugins" },
        },
    },
    modules = {
        "config.autocommands",
        "config.keymaps",
    },
})
