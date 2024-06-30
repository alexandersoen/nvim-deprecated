local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    return
end

local sources = {
    -- python
    null_ls.builtins.formatting.black.with({
        extra_args = { "--line-length=79", "--preview" }
    }),
    null_ls.builtins.formatting.isort,

    -- lua
    null_ls.builtins.formatting.lua_format,
}

local on_attach = function(client)
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
end

null_ls.setup({
    debug = true,
    sources = sources,
    on_attach = on_attach,
})
