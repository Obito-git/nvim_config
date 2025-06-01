vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.opt.scrolloff = 10
-- vim.opt.mouse = ""
vim.g.mapleader = " "

-- disable standart file explorer because it breaks directories when switch to buf
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- requires gvim to be installed
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to the system clipboard" })
vim.keymap.set({ "v", "n", "i" }, "<C-v>", '"+p', { desc = "Paste from the system clipboard" })

-- Map Ctrl+N in terminal mode to exit to normal mode
vim.keymap.set('t', '<C-N>', '<C-\\><C-N>', {
  noremap = true,
  silent = true,
  desc = "Terminal: Exit to Normal Mode"
})

vim.keymap.set(
	"n",
	"<PageDown>",
	"7<C-e>",
	{ noremap = true, silent = true, desc = "Scroll down 5 lines (no cursor move)" }
)
vim.keymap.set(
	"n",
	"<PageUp>",
	"7<C-y>",
	{ noremap = true, silent = true, desc = "Scroll up 5 lines (no cursor move)" }
)

vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = "Window: Navigate Left" })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = "Window: Navigate Down" })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = "Window: Navigate Up" })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = "Window: Navigate Right" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
