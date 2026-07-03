vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, { confirm = false })
require("render-markdown").setup({
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
})
vim.keymap.set("n", "<leader>m", function() require("render-markdown").buf_toggle() end, { desc = "Toggle markdown rendering" })
