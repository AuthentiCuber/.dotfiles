require("option")
require("lsp")

vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/nvim-mini/mini.statusline" },
    { src = "https://github.com/navarasu/onedark.nvim" },
})

require("onedark").setup({
    style = "dark"
})
require("onedark").load()

require("mini.statusline").setup()
