vim.pack.add({
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1.0.0") },
}, { confirm = false })

require("mini.snippets").setup({
    snippets = { require("mini.snippets").gen_loader.from_lang() },
    mappings = { expand = "", jump_next = "", jump_prev = "" },
})

require("blink.cmp").setup({
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
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                },
            },
        },
    },
    cmdline = {
        enabled = true,
        keymap = {
            preset = "none",
            ["<C-space>"] = { "show", "hide" },
            ["<Esc>"] = { "cancel", "hide", "fallback" },
            ["<Tab>"] = { "accept", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
        },
        completion = {
            menu = { auto_show = true },
            list = { selection = { preselect = true, auto_insert = false } },
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
        default = { "lsp", "path", "snippets", "buffer", "lazydev", "markdown" },
        providers = {
            ["lazydev"] = {
                name = "LazyDev",
                fallbacks = { "lsp" },
                module = "lazydev.integrations.blink",
            },
            ["markdown"] = {
                name = "RenderMarkdown",
                fallbacks = { "lsp" },
                module = "render-markdown.integ.blink",
            },
        },
    },
    snippets = {
        preset = "mini_snippets",
    },
})
