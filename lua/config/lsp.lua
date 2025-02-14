-- Example LSP server configuration file.
--
-- Should return a table of LSP server definitions, indexed by LSP server name.
return {
    -- ["server-name"] = {
    --     -- All fields are optional
    --     cmd = {...},
    --     filetypes = {...},
    --     capabilities = {...},
    --     settings = {...},
    -- },
    -- ...
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                -- You can toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
                -- diagnostics = { disable = { "missing-fields" } },
            },
        },
    },
    phpactor = {},
}
