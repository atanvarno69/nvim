local servers = {}
for _, path in ipairs(vim.fn.glob("~/.config/nvim/lsp/*", false, true)) do
    local name = vim.fn.fnamemodify(path, ":t")
    name = name:match("(.+)%..+$") or name
    servers[#servers + 1] = name
end
vim.lsp.enable(servers)
