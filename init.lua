--[[

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

--]]

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.breakindent = true
vim.o.undofile = true -- Save undo history (after re-opening)
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scrolloff = 15 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.confirm = true -- When exit with unsaved will trigger a dialog

-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<PageDown>', '7<C-e>', { noremap = true, silent = true, desc = 'Scroll down 7 lines (no cursor move)' })
vim.keymap.set('n', '<PageUp>', '7<C-y>', { noremap = true, silent = true, desc = 'Scroll up 7 lines (no cursor move)' })

-- requires gvim to be installed
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to the system clipboard' })
vim.keymap.set({ 'v', 'n', 'i' }, '<C-v>', '"+p', { desc = 'Paste from the system clipboard' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps (show all warns/errors in the current file)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Open existing term or new, when opened then hide
local term_buf = nil
local term_win = nil

function ToggleTerminal()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    if term_win and vim.api.nvim_win_is_valid(term_win) then
      vim.api.nvim_win_hide(term_win)
      term_win = nil
    else
      vim.cmd('botright sbuf ' .. term_buf)
      vim.cmd 'resize 10'
      term_win = vim.api.nvim_get_current_win()
    end
  else
    vim.cmd 'botright split | term'
    vim.cmd 'resize 10'
    term_buf = vim.api.nvim_get_current_buf()
    term_win = vim.api.nvim_get_current_win()
    vim.cmd 'startinsert'
  end
end
vim.keymap.set({ 'n', 't' }, '<leader>tt', ToggleTerminal, { desc = '[T]oggle [T]erminal' })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- TODO: Re-enable when get use to hjkl
vim.keymap.set('n', '<left>', '<cmd>echoe "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echoe "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echoe "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echoe "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Install lazy if it is not already installed
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup('plugins', {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
