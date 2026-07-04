vim.lsp.config("pylsp", {
    settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
            }
        }
    }
})

vim.lsp.config("hls", {
    settings = {
        haskell = {
            plugins = {
                semantictokens = { globalOn = true },
            }
        }
    }
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
        if client:supports_method("textDocument/formatting")
            and not client:supports_method("textDocument/willSaveWaitUntil") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.client_id, timeout = 1000 })
                end
            })
        end
    end,
})

vim.opt.complete:append("o")
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.pumheight = 5
vim.o.pumborder = "rounded"
