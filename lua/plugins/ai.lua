return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-n>', '<Plug>(copilot-accept-word)', {
      desc = 'Accept next word of Copilot suggestion',
    })
  end,
}
