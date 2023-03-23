local opts = { noremap = true, silent = true }

-- Shortern
local keymap = vim.keymap.set

vim.g.mapleader = " "

-- Modes 
--      normal_mode = "n"
--      insert_mode = "i"
--      visual_mode = "v"
--      visual_block_mode = "x"
--      term_mode = "t"
--      command_mode = "c"

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


-- keymap("n", "<leader>pe", ":30Lex <cr>", opts)
keymap("n", "<leader>pe", ":Neotree filesystem toggle float <cr>", opts)
keymap("n", "<leader>pg", ":Neotree git_status toggle float <cr>", opts)
keymap("n", "<leader>pb", ":Neotree buffers toggle float <cr>", opts)


-- keymap("n", "<leader>gs", vim.cmd.Git)
keymap("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

-- Insert --
--

-- Visual --
-- Stay in visual when moving left and right
keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

-- Move text up and down
keymap("v", "<M-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<M-k>", ":m '<-2<CR>gv=gv", opts)

-- Visual Block --
--

-- Command --
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

keymap("t", "gt", "<C-\\><C-N>gt", opts)
keymap("t", "gT", "<C-\\><C-N>gT", opts)
