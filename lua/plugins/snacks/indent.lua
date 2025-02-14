return {
    "folke/snacks.nvim",
    opts = {
        indent = {
            indent = {
                char = "│",
                hl = { "rainbow6", "rainbow5", "rainbow4", "rainbow3", "rainbow2", "rainbow1" },
            },
            animate = { enabled = false },
            scope = { hl = "Keyword" },
            filter = function(buf)
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and vim.bo[buf].filetype ~= "markdown"
            end,
        },
    },
}
