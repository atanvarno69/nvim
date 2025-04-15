local M = {
    opts = {
        repository = {
            icon = "",
            color = "diffFile",
        },
        filename = {
            symbols = {
                modified = " ",
                readonly = " ",
                unnamed = "",
                newfile = " ",
            },
        },
    },
}

---@return string
function M.repo_name()
    local git_dir = require("lualine.components.branch.git_branch").find_git_dir()
    if git_dir == nil or git_dir == "" then
        return ""
    end
    return vim.fs.basename(vim.fs.dirname(git_dir))
end

---@param absolute_path string
---@return string
function M.home_compact(absolute_path)
    local home = os.getenv("HOME")
    if home == nil then
        return absolute_path
    end
    local start, _ = absolute_path:find(home)
    if start ~= 1 then
        return absolute_path
    end
    return "~" .. absolute_path:sub(home:len() + 1, absolute_path:len())
end

---@param absolute_path string
---@return string
function M.git_compact(absolute_path)
    local git_dir = require("lualine.components.branch.git_branch").find_git_dir()
    if git_dir == nil or git_dir == "" then
        return absolute_path
    end
    local git_root = vim.fs.dirname(git_dir)
    return absolute_path:sub(git_root:len() + 2)
end

---@return boolean
function M.is_new_file()
    local filename = vim.fn.expand("%")
    return filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0
end

---@return string
function M.filename()
    local abs_path = vim.fn.expand("%:p")
    local name = M.git_compact(abs_path)
    if name == abs_path then
        name = M.home_compact(abs_path)
    end
    name = name .. ":%l:%c"
    if vim.bo.modified then
        name = name .. M.opts.filename.symbols.modified
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        name = name .. M.opts.filename.symbols.readonly
    end
    if M.is_new_file() then
        name = name .. M.opts.filename.symbols.newfile
    end
    return name
end

function M.lsp()
    local buf_ft = vim.api.nvim_get_option_value("filetype", {})
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then
        return ""
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            local icon, _, _ = require("mini.icons").get("filetype", buf_ft)
            return icon .. " " .. client.name
        end
    end
    return ""
end

return M
