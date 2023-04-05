-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Packer did not start")
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install plugins
packer.startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Colour Scheme --
    use 'Mofiqul/dracula.nvim'

--    -- Completition --
--    use 'hrsh7th/nvim-cmp'         -- Required
--    use 'hrsh7th/cmp-buffer'       -- Optional
--    use 'hrsh7th/cmp-path'         -- Optional
--    use 'hrsh7th/cmp-cmdline'         -- Optional
--    use 'saadparwaiz1/cmp_luasnip' -- Optional
--
--    -- Snippets
--    use 'L3MON4D3/LuaSnip'             -- Required
--    use 'rafamadriz/friendly-snippets' -- Optional
--
--    -- LSP
--    use "williamboman/mason.nvim"
--    use "williamboman/mason-lspconfig.nvim"
--    use "neovim/nvim-lspconfig"  -- enable LSP
--    use "hrsh7th/cmp-nvim-lsp"

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- Fuzzy Finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"
    }
    use 'nvim-treesitter/nvim-treesitter-context'

    -- Harpoon
    use 'theprimeagen/harpoon'

    -- Undo Tree
    use 'mbbill/undotree'

    -- Git
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'


    -- Funny vim game
    use 'ThePrimeagen/vim-be-good'

    -- LaTex Stuff
    use 'lervag/vimtex'

    -- Jupyter notebook stuff
    use 'goerz/jupytext.vim'

    -- Bars and appearance
--     use {
--         'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'
--     }
    use {
        'nvim-lualine/lualine.nvim', requires = {
            'kyazdani42/nvim-web-devicons', opt = true
        }

    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }
end)
