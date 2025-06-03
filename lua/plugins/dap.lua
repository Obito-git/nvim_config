return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    config = function()
      -- Styles

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "🔴", texthl = "DapBreakpointSign", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "🟠", texthl = "DapBreakpointConditionSign", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "🚫", texthl = "DapBreakpointRejectedSign", linehl = "", numhl = "" }
      )

      vim.fn.sign_define("DapStopped", {
        text = "🟢",
        texthl = "DapStoppedIcon",
        linehl = "DapStoppedLineBG",
        numhl = "DapStoppedNumber",
      })

      vim.api.nvim_set_hl(0, "DapStoppedIcon", { fg = "#33DD33" })
      vim.api.nvim_set_hl(0, "DapStoppedLineBG", { bg = "#204020" })
      vim.api.nvim_set_hl(0, "DapStoppedLineBG", { fg = "White", bg = "#204020" })
      vim.api.nvim_set_hl(0, "DapStoppedNumber", { fg = "#60A060", bold = true })
      vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "Red" })
      vim.api.nvim_set_hl(0, "DapBreakpointConditionSign", { fg = "Orange" })
      vim.api.nvim_set_hl(0, "DapBreakpointRejectedSign", { fg = "Gray" })

      -- Key mappings

      vim.keymap.set("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
      vim.keymap.set("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
      vim.keymap.set("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
      vim.keymap.set("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
      vim.keymap.set(
        "n",
        "<Leader>db",
        "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
        { desc = "Debugger toggle breakpoint" }
      )
      vim.keymap.set(
        "n",
        "<Leader>dd",
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        { desc = "Debugger set conditional breakpoint" }
      )
      vim.keymap.set("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
      vim.keymap.set("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })
      vim.keymap.set("n", "<Leader>ds", "<cmd>DapTerminate<CR>", { desc = "Debugger run last" })
      vim.keymap.set("n", "<Leader>k", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, { silent = true, buffer = bufnr })
      vim.keymap.set("n", "<Leader>duo", "<cmd>lua require'dapui'.open()<CR>", { desc = "Debugger continue" })
      vim.keymap.set("n", "<Leader>duc", "<cmd>lua require'dapui'.close()<CR>", { desc = "Debugger continue" })
      vim.keymap.set("n", "<Leader>dt", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Debugger continue" })

      --vim.keymap.set(
      --  "n",
      --  "<Leader>dt",
      --  "<cmd>lua vim.cmd('RustLsp testables')<CR>",
      --  { desc = "Debugger testables" }
      --)

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
