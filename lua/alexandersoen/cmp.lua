local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load({
    region_check_events = "CursorHold,InsertLeave",
    -- those are for removing deleted snippets, also a common problem
    delete_check_events = "TextChanged,InsertEnter",
})

-- Helper for
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup({
    -- Snip location
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },


    -- Autocomplete window and documentation window
    window = {
        completion = cmp.config.window.bordered({
            border = 'rounded',
            scrolloff = 4,
        }),
        documentation = cmp.config.window.bordered(),
    },


    -- Key Mappings --
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.abort()
            else
                cmp.complete()
            end
        end, { 'i', 'c' }
        ),
        ["<C-e>"] = cmp.mapping.abort(),

        -- Do not make <CR> enter if menu not open
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.mapping.confirm({ select = true })
            end
            fallback()
        end, { 'i', 'c' }

        ), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["C-p"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["C-n"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),


    -- Formatting (autocomplete menu)
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },

    completion = {
        autocomplete = false,
    },

    -- Sources for autocomplete
    sources = cmp.config.sources({
        { name = "luasnip" }, -- For luasnip users.
        { name = "buffer" },
        { name = "path" },
    }),


    -- Just adding ghost text
    experimental = {
        ghost_text = true -- need to turn off if copilot is used
    }
})
