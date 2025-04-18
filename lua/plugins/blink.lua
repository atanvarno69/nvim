return {
    "saghen/blink.cmp",
    version = "v0.*",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                        require("luasnip.loaders.from_vscode").lazy_load({
                            paths = { vim.fn.stdpath("config") .. "/snippets" },
                        })
                    end,
                },
            },
            opts = {},
            lazy = true,
        },
    },
    opts = {
        appearance = {
            nerd_font_variant = "normal",
        },
        completion = {
            accept = { dot_repeat = false },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            keyword = { range = "full" },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
            menu = {
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "source_name" },
                    },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                return kind_icon
                            end,
                            -- Optionally, you may also use the highlights from mini.icons
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
        },
        keymap = {
            preset = "none",
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<Esc>"] = { "cancel", "hide", "fallback" },
            ["<Tab>"] = { "accept", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<C-Tab>"] = { "snippet_forward", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
            ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        snippets = {
            preset = "luasnip",
        },
    },
    opts_extend = { "sources.default" },
    event = { "BufEnter" },
}
