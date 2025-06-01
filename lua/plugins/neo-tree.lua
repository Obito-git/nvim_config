return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    { "3rd/image.nvim", opts = {} },
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    local last_focused_non_neotree_window_id = nil

    local function toggle_neotree_focus()
      local current_win_id = vim.api.nvim_get_current_win()
      local current_buf_id = vim.api.nvim_win_get_buf(current_win_id)

      if vim.bo[current_buf_id] and vim.bo[current_buf_id].filetype == "neo-tree" then
        if
            last_focused_non_neotree_window_id and vim.api.nvim_win_is_valid(last_focused_non_neotree_window_id)
        then
          vim.api.nvim_set_current_win(last_focused_non_neotree_window_id)
        else
          vim.cmd.wincmd("p")
        end
      else
        last_focused_non_neotree_window_id = current_win_id
        vim.cmd("Neotree reveal")
      end
    end
    vim.keymap.set("n", "<leader>ee", toggle_neotree_focus, { desc = "Focus current buffer/file. " })
    vim.keymap.set("n", "<leader>es", "<Cmd>Neotree toggle<CR>", {
      noremap = true,
      silent = true,
      desc = "Hide/show explorer",
    })
    require("neo-tree").setup({
      close_if_last_window = true,
    })
  end,
}
