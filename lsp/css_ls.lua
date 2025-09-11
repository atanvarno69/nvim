return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    init_options = { provideFormatter = true },
    root_markers = { "package.json", ".git" },
    settings = {
        css = {
            validate = true,
            format = { newlineBetweenSelectors = false },
        },
        scss = {
            validate = true,
            format = { newlineBetweenSelectors = false },
        },
        less = {
            validate = true,
            format = { newlineBetweenSelectors = false },
        },
    },
}
