return {
    "lukas-reineke/virt-column.nvim",
    init = function(_)
        vim.g.virt_column_enabled = true
    end,
    opts = {
        enabled = true,
        char = "▏",
        virtcolumn = "81,121",
        exclude = {
            filetypes = {
                "lspinfo",
                "checkhealth",
                "help",
                "man",
                "gitcommit",
                "oil",
            },
        },
    },
    event = { "BufEnter", "BufNew" },
    keys = {
        {
            "<leader>|",
            function()
                require("virt-column").update({ enabled = not vim.g.virt_column_enabled })
                vim.g.virt_column_enabled = not vim.g.virt_column_enabled
                vim.cmd("redraw!")
            end,
            desc = "Toggle virtual column",
            mode = "n",
        },
    },
}
