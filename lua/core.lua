-- WARN: You should not edit this file. See lua/config/init.lua.
--
-- Loads your configuration and provides lazy.nvim installation.

---@class coreConfig
---@field lazy LazyConfig? lazy.nvim configuration to use.
---@field early string[]? Modules to load before lazy.nvim (e.g. to set leader and localleader).
---@field modules string[]? Modules to load after lazy.nvim. This will be most of the user defined configuration.
local defaults = {
    lazy = {
        install = { colorscheme = { "default" } },
        checker = { enabled = true, notify = false },
        performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
    },
    early = {},
    modules = {},
}

local function bootstrap_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out, "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
    return require("lazy")
end

---@param module_name string
local function load_module(module_name)
    if not module_name then
        return false, nil
    end
    local ok, module = pcall(require, module_name)
    if not ok then
        vim.api.nvim_echo({
            { "Core failed to load module " },
            { module_name },
            { "\n" },
        }, true, { err = true })
    end
    return ok, module or nil
end

---@class core
local M = {}

---@param opts coreConfig?
function M.setup(opts)
    -- Get options
    local options = vim.tbl_deep_extend("force", defaults, opts or {})

    -- Install and return lazy.nvim
    local lazy = bootstrap_lazy()

    -- Load early modules
    for _, early_module in pairs(options.early or {}) do
        load_module(early_module)
    end

    -- Setup lazy.nvim
    lazy.setup(options.lazy)

    -- Load configuration modules
    for _, module in pairs(options.modules or {}) do
        load_module(module)
    end
end

return M
