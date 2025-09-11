return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-mini/mini.icons",
        },
        opts = {
            heading = {
                icons = { " " },
                position = "inline",
                width = "block",
                min_width = 120,
            },
            code = {
                sign = true,
                style = "full",
                width = "block",
                min_width = 119,
                left_pad = 1,
                above = "▄",
                below = "▀",
            },
            dash = {
                icon = "─",
                width = 120,
            },
            bullet = { icons = { "•", "◦", "‣", "⁃" } },
            checkbox = {
                unchecked = { icon = "  " },
                checked = { icon = "  " },
            },
            quote = { icon = "▌" },
            pipe_table = {
                border = {
                    "┌",
                    "┬",
                    "┐",
                    "├",
                    "┼",
                    "┤",
                    "└",
                    "┴",
                    "┘",
                    "│",
                    "─",
                },
                alignment_indicator = "━",
            },
            link = {
                email = " ",
            },
            completions = {
                lsp = {
                    enabled = true,
                },
            },
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
