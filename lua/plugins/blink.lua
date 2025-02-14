return {
    "saghen/blink.cmp",
    opts = {
        keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<Esc>"] = { "cancel", "hide", "fallback" },
            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            ["<C-j>"] = { "scroll_documentation_down", "fallback" },
        },
    },
}
