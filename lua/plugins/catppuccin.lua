return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("catppuccin")
    end,
    opts = {
        flavour = "mocha",
        default_integrations = false,
        integrations = {
            blink_cmp = {
                style = "bordered",
            },
            gitsigns = true,
            mason = true,
            mini = {
                enabled = true,
                indentscope_color = "lavender",
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            noice = true,
            notify = true,
            render_markdown = true,
            semantic_tokens = true,
            snacks = true,
            treesitter = true,
            ufo = true,
            which_key = true,
        },
    },
}
