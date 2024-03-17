return {
    -- Native Telescope sorter using fzf
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = false,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },

    -- Telescope for fuzzy search
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function ()
            local telescope = require("telescope")
            telescope.setup {
                extensions = {
                    fzf = {}
                }
            }
            telescope.load_extension("fzf")
        end
    },
}
