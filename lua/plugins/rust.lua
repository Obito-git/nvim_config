return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    ft = "rust",
    config = function()
      local codelldb = vim.fn.expand("$MASON/packages/codelldb")
      local extension_path = codelldb .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require("rustaceanvim.config")

      return {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
          configurations = {
            launch = {
              console = "integratedTerminal", -- Keep this for console I/O
              args = function()
                local args_str = vim.fn.input("Enter program arguments: ")
                if args_str == "" then
                  return {} -- Return an empty table if no arguments are entered
                end
                -- vim.split splits the string by spaces into a table of arguments
                return vim.split(args_str, " ")
              end,
            },
          },
        },
      }
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
        },
      })
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
    end,
  },
}
