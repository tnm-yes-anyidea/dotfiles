-- ~/.config/nvim/lua/core/keybinds.lua

-- Safe plugin loading with error handling
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load " .. module, vim.log.levels.WARN)
    return nil
  end
  return result
end

local dap = safe_require("dap")
local dapui = safe_require("dapui")
local fzf = safe_require("fzf-lua")

-- ─────────────────────────────────────────────────────────────
-- Terminal
-- ─────────────────────────────────────────────────────────────
local launch_dir = vim.fn.getcwd()
local first_arg = vim.fn.argv(0) or ""

if vim.fn.isdirectory(first_arg) == 1 then
  launch_dir = vim.fn.fnamemodify(first_arg, ":p")
end

-- Open terminal in launch directory
vim.keymap.set('n', '<C-t>', function()
  vim.cmd("lcd " .. launch_dir)
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { silent = true, desc = "Open terminal in launch directory" })

-- Exit terminal mode
vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]], { silent = true })

-- ─────────────────────────────────────────────────────────────
-- Ctrl+P: Find Files
-- ─────────────────────────────────────────────────────────────
if fzf then
  vim.keymap.set("n", "<C-p>", fzf.files, { desc = "Find Files" })
end

-- ─────────────────────────────────────────────────────────────
-- DAP (Debugger)
-- ─────────────────────────────────────────────────────────────
if dap then
  vim.keymap.set("n", "<F3>", dap.continue, { desc = "Debug: Continue" })
  vim.keymap.set("n", "<F8>", dap.toggle_breakpoint, { desc = "Debug: Breakpoint" })
  vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
  vim.keymap.set("n", "<F12>", dap.step_into, { desc = "Debug: Step Into" })
  vim.keymap.set("n", "<S-F12>", dap.step_out, { desc = "Debug: Step Out" })
  vim.keymap.set("n", "<S-F3>", dap.terminate, { desc = "Debug: Stop" })
end

if dapui then
  vim.keymap.set("n", "<F4>", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
  vim.keymap.set("n", "<F6>", function() require("dapui").eval() end, { desc = "Debug: Evaluate" })
end

-- ─────────────────────────────────────────────────────────────
-- F5: Smart Run
-- ─────────────────────────────────────────────────────────────
if dap then
  vim.keymap.set("n", "<F5>", function()
    local ft = vim.bo.filetype
    local has_breakpoints = false
    for _, v in pairs(require("dap.breakpoints").get()) do
      if #v > 0 then has_breakpoints = true; break end
    end

    if ft == "python" then
      if has_breakpoints then
        dap.continue()
      else
        vim.cmd("w | split | term python3 " .. vim.fn.expand("%"))
      end

    elseif ft == "c" or ft == "cpp" then
      local source   = vim.fn.expand("%")
      local output   = vim.fn.expand("%:p:r")
      local compiler = (ft == "c") and "gcc" or "g++"
      local ok = os.execute(string.format('%s -g "%s" -o "%s"', compiler, source, output))
      if ok ~= 0 then vim.notify("Compilation failed", vim.log.levels.ERROR); return end
      if has_breakpoints then
        dap.continue()
      else
        vim.cmd("split | term " .. output)
      end

    else
      vim.notify("No run config for filetype: " .. ft, vim.log.levels.WARN)
    end
  end, { desc = "Smart Run / Debug" })
end

-- ─────────────────────────────────────────────────────────────
-- map_run: plain run for other languages
-- ─────────────────────────────────────────────────────────────
local function map_run(lang, cmd)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = lang,
    callback = function()
      local final_cmd = ":w | split | term " .. cmd .. "<CR>i"
      vim.keymap.set("n", "<F5>", final_cmd, { buffer = true, silent = true })
    end,
  })
end

map_run("fortran", "gfortran % -o %< && ./%<")
map_run("julia",   "julia %")
map_run("go",      "go run %")
map_run("rust",    "cargo run")
map_run("lua",     "lua %")
map_run("php",     "php %")
map_run("ruby",    "ruby %")
map_run("perl",    "perl %")
map_run("java",    "javac % && java %:r && rm %:r.class")

-- ─────────────────────────────────────────────────────────────
-- LeetCode
-- ─────────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<CR>", { desc = "LeetCode Submit" })
vim.keymap.set("n", "<leader>lt", "<cmd>Leet test<CR>", { desc = "LeetCode Test" })
vim.keymap.set("n", "<leader>ll", "<cmd>Leet<CR>", { desc = "LeetCode Menu" })
