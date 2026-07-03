vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "php_cs_fixer" },
        rust = { "rustfmt" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})
vim.keymap.set(
    "n",
    "<leader>F",
    function()
        require("conform").format({ async = true }, function(err)
            if not err then
                local mode = vim.api.nvim_get_mode().mode
                if vim.startswith(string.lower(mode), "v") then
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                end
            end
        end)
    end,
    { desc = "Format" }
)
