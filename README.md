# ⚡ Neovim Development Environment

A modular, fast, and feature-complete Neovim configuration built for competitive programming, multi-language software development, and interactive debugging.

---

## 🛠️ Key Features

* **File Explorer**: `nvim-tree` automatically opens when opening directories and synchronizes with CWD[cite: 7].
* **LeetCode Integration**: Solve, test, and submit LeetCode problems natively via `leetcode.nvim`[cite: 1, 5].
* **Full LSP Support**: Powered by `mason.nvim` and `nvim-lspconfig` for dynamic language server setup[cite: 6].
* **Interactive Debugging**: Full DAP integration with `nvim-dap` and `nvim-dap-ui` for C/C++, Python, and Go[cite: 1, 4].
* **Fuzzy Finder**: Blazing fast file search using `fzf-lua` (`<C-p>`)[cite: 1, 7].
* **Git Workflows**: Embedded terminal split and `LazyGit` overlay (`<leader>gg` / `<F7>`)[cite: 1, 7].

---

## 🚀 Usage & Commands

### Opening Neovim

| Command | Action |
| :--- | :--- |
| `nvim .` | Opens Neovim with `nvim-tree` active on the current directory[cite: 7]. |
| `nvim file.ext` | Opens a specific file with relevant LSP / DAP active[cite: 6]. |
| `nvim leetcode.nvim` | Opens the interactive LeetCode dashboard[cite: 5]. |

---

## ⌨️ Keybindings

### 🧩 General & File Navigation
* `<leader>e` — Toggle `nvim-tree` file explorer[cite: 7]
* `r` *(inside nvim-tree)* — Rename file or directory on disk
* `<C-p>` — Find files using `fzf-lua`[cite: 1, 7]
* `<C-t>` — Open terminal split in root launch directory[cite: 1]
* `<leader>gg` / `<F7>` — Open `LazyGit`[cite: 7]

### 💡 LSP (Language Server Protocol)
* `gd` — Go to definition[cite: 6]
* `gD` — Go to declaration[cite: 6]
* `gi` — Go to implementation[cite: 6]
* `K` — Hover documentation[cite: 6]
* `<leader>rn` — Rename symbol/variable across project[cite: 6]
* `<leader>ca` — Code actions[cite: 6]
* `<leader>f` — Format buffer[cite: 6]
* `<leader>d` — Show line diagnostics / errors[cite: 6]

### 🐛 Debugging (DAP) & Execution
* `<F8>` — Toggle Breakpoint[cite: 1]
* `<F5>` — **Smart Run / Debug**: Starts debugger if breakpoints are set; otherwise runs script in terminal split[cite: 1]
* `<F10>` — Step Over[cite: 1]
* `<F12>` — Step Into[cite: 1]
* `<S-F12>` — Step Out[cite: 1]
* `<F3>` — Continue execution[cite: 1]
* `<S-F3>` — Terminate debug session[cite: 1]
* `<F4>` — Toggle Debugger UI (`dapui`) manually[cite: 1]

### 🧩 LeetCode Integration
* `<leader>ll` — Open LeetCode Menu[cite: 1]
* `<leader>lt` — Run LeetCode test cases[cite: 1]
* `<leader>ls` — Submit LeetCode solution[cite: 1]

---

## 🗂️ Project Structure

```text
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/
    │   ├── keybinds.lua    # Global keybindings & Smart Run
    │   └── options.lua     # Vim options (tabs, numbers, clipboard)
    └── plugins/
        ├── completions.lua # nvim-cmp & LuaSnip
        ├── dap.lua         # nvim-dap & mason-nvim-dap
        ├── leetcode.lua    # LeetCode environment
        ├── lsp.lua         # Mason & lspconfig handlers
        ├── tools.lua       # nvim-tree, fzf-lua, treesitter, lazygit
        └── ui.lua          # Tokyo Night theme setup
