local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local config_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not config_status_ok then
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
    }
})

Handlers for LSP startup
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local function on_attach(client, bufnr)
    -- Helper for setting key bindings
    local opts = { buffer = bufnr, noremap = true, silent = true }
    _ = client  -- Getting rid of warning lol

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Key bindings
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end

-- Other settings for LSP
local lsp_settings = {
    lua_ls = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
    hls = {
        rootMarkers = {"./git"},
    },
}

-- Configure the LSP
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
    function(server_name)
        -- Just incase there is undefined behaviour with nil settings
        if lsp_settings[server_name] ~= nil then
            lspconfig[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                root_dir = vim.loop.cwd,
                settings = lsp_settings[server_name],
            })
        else
            lspconfig[server_name].setup({
                on_attach = on_attach,
                root_dir = vim.loop.cwd,
                capabilities = capabilities,
            })
        end

        -- Loading this in manually (doesn't seem to work with Mason install)
        lspconfig["hls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
})
