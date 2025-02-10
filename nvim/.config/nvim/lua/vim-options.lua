-- Leader-key
vim.g.mapleader = " "
-- Tab = 2 spaces wide
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.background = "light"

vim.opt.swapfile = false
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

-- Quickfix-list navigation keys
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>zz')

-- Nvim-Terminal - Ctrl+z, then fg, also an option though
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.keymap.set('t', '<Leader><ESC>', '<C-\\><C-n>', { noremap = true })
  end,
})
-- From Teej's vid about this; for 'small terminal' and 'big terminal'
vim.keymap.set('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)
vim.keymap.set('n', '<space>bt', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 45)
end)

-- move lines up and down!! Yess
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- update these commands to have line w/ cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

