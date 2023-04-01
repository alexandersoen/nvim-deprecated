-- :help options
local options = {
    clipboard = "unnamedplus",  -- allows neovim to access the system clipboard

    hlsearch = false,           -- highlight all matches on last search pattern
    incsearch = true,           -- highlight matches on search

    pumheight = 10,             -- pop up menu height

    showtabline = 2,            -- always shows window tabs
    smartcase = true,           -- smart case
    smartindent = true,         -- make indenting smarter
    splitbelow = true,          -- force horizontal splits to be below current window
    splitright = true,          -- force vertical splits to be right of current window

    termguicolors = true,       -- set term gui colours
    background = "dark",        -- set term background to dark

    undofile = true,            -- enable persistent undos

    expandtab = true,           -- tabs to spaces
    shiftwidth = 4,             -- the number of spaces per indentation
    tabstop = 4,                -- spaces per tab

    cursorline = true,          -- underline for cursor position
    number = true,              -- line numbers
    relativenumber = true,      -- relative number lines
    signcolumn = "yes",         -- shows the sign column on the left of the numbers?

    scrolloff = 8,              -- minimum lines above and below when scrolling
    sidescrolloff = 8,          -- minimum lines left and right when scrolling (I think)

    colorcolumn = "80",         --  Verticle line @ row number

    updatetime = 50,            -- Update time
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
