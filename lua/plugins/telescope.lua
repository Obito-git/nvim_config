return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- replaced by snacks picker
      -- local builtin = require("telescope.builtin")
      -- vim.keymap.set("n", "<leader>o", builtin.find_files, {})
      -- vim.keymap.set("n", "<leader>f", builtin.current_buffer_fuzzy_find, {})
      -- vim.keymap.set("n", "<leader>ff", builtin.live_grep, {})
      vim.keymap.set(
        "n",
        "<leader>sb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>",
        {}
      )

      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["d"] = require("telescope.actions").delete_buffer,
              ["q"] = require("telescope.actions").close,
            },
          },
          layout_config = {
            width = function(_, cols, _)
              if cols > 200 then
                return 170
              else
                return math.floor(cols * 0.87)
              end
            end,
            preview_cutoff = 120,
          },
        },
      })
    end,
  },
}
