require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c", "cmake", "cpp", "glsl", "java", "kotlin", "json", "lua",
                         "make", "python", "query", "regex", "rust", "toml", "typescript", "vim",
                         "yaml" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
