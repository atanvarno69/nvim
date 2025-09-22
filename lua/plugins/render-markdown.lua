return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-mini/mini.icons",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            restart_highlighter = true,
            latex = { enabled = false },
            completions = {
                lsp = { enabled = true },
                blink = { enabled = true },
            },
            heading = {
                sign = false,
                icons = { " " },
                position = "inline",
                width = "block",
                min_width = 120,
            },
            code = {
                sign = true,
                width = "block",
                min_width = 119,
                left_pad = 1,
                border = "thick",
            },
            dash = {
                icon = "─",
                width = 120,
            },
            bullet = { icons = { "•", "◦", "‣", "⁃" } },
            quote = { icon = "▌" },
            link = { email = " " },
            html = { enabled = false },
        },
        ft = "markdown",
        keys = {
            {
                "<leader>m",
                function()
                    require("render-markdown").buf_toggle()
                end,
                mode = "n",
                desc = "Toggle markdown rendering",
            },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "markdown" },
                providers = {
                    markdown = {
                        name = "RenderMarkdown",
                        fallbacks = { "lsp" },
                        module = "render-markdown.integ.blink",
                    },
                },
            },
        },
    },
}
