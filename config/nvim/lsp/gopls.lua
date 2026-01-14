return {
    cmd = { 'gopls' },
    filetypes = { "go" },
    root_markers = {
        ".git",
        "go.sum",
        "go.work",
        "go.mod",
    },

    settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
            undeclarednames = true,
            ST1000 = false,
          },
          usePlaceholders = true,
        },
    },
}
