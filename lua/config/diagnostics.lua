---@type vim.diagnostic.Opts
local config = {
    virtual_text = { current_line = true, source = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
}

vim.diagnostic.config(config)
