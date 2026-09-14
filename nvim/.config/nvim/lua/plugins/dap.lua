-- ~/.config/nvim/lua/plugins/dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
    lazy = true,
    dependencies = { "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",},
    config = function()
      local dap = require("dap")
      
      -- Python debugging configuration
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- Try to find python3 in PATH
            local handle = io.popen("which python3")
            if handle then
              local result = handle:read("*a"):gsub("\n", "")
              handle:close()
              return result ~= "" and result or "python3"
            end
            return "python3"
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          console = "integratedTerminal",
        },
        {
          type = "python",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          pythonPath = function()
            local handle = io.popen("which python3")
            if handle then
              local result = handle:read("*a"):gsub("\n", "")
              handle:close()
              return result ~= "" and result or "python3"
            end
            return "python3"
          end,
        },
      }
      
      -- C/C++ debugging
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "lldb-mi",
      }
      
      dap.configurations.c = {
        {
          name = "Launch",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          MIMode = "lldb",
        },
      }
      
      dap.configurations.cpp = dap.configurations.c
      
      -- Go debugging
      dap.adapters.go = {
        type = "executable",
        command = "dlv",
        args = { "dap" },
      }
      
      dap.configurations.go = {
        {
          type = "go",
          name = "Attach",
          mode = "local",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    lazy = true,
    config = function()
      require("dapui").setup()
    end,
  },
}
