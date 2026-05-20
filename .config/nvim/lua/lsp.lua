vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c" }
})

vim.lsp.enable("pylsp")
vim.lsp.enable("ruff")
vim.lsp.enable("clangd")
vim.lsp.enable("hls")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
        end
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = ev.data.client_id }
            end
        })
    end,
})

vim.opt.complete:append("o")
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.pumheight = 5
vim.o.pumborder = "rounded"
