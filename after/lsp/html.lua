---@type vim.lsp.Config
local config = {
    ---@type lspconfig.settings.html
    settings = {
        html = {
            format = {
                extraLiners = "",
                indentInnerHtml = true,
                wrapLineLength = 0,
                wrapAttributes = "never",
            }
        }
    },
}
return config
