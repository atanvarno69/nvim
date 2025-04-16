return {
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            views = {
                cmdline_popup = {
                    border = { style = "single" },
                },
                popupmenu = {
                    border = { style = "single" },
                },
            },
        },
        event = { "VeryLazy" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "lua",
                "markdown",
                "markdown_inline",
                "regex",
                "vim",
            },
        },
    },
}
