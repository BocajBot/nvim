# Neovim configuration

A Lua-based Neovim configuration using **lazy.nvim**, **nvim-cmp/LuaSnip**, Mason, the built-in LSP configuration API, and Tree-sitter.

**Required Neovim:** 0.12.x (stable), because this configuration tracks the `nvim-treesitter` `main` branch.

## Upgrade

On CachyOS/Arch Linux, upgrade the installed editor with:

```sh
sudo pacman -Syu neovim tree-sitter-cli base-devel
nvim --version | head -1
tree-sitter --version
```

Then open Neovim and run:

```vim
:Lazy sync
:TSUpdate
:checkhealth kickstart
```

`nvim-treesitter/main` requires `tree-sitter-cli` **0.26.1+**, `tar`, `curl`, and a C compiler. If your package manager ships an older Tree-sitter CLI, install a compatible version before updating parsers.

## Neovim 0.12 features

| Action | Command / mapping |
| --- | --- |
| Compare two files or directories | `:DiffTool left right` |
| Open the native undo tree | `<leader>U` (Shift-U) |
| Open the existing mbbill/undotree UI | `<leader>u` |
| Check version compatibility | `:checkhealth kickstart` |

The native diff tool loads at startup on Neovim 0.12+. The native undo tree loads only when its mapping is used. The existing third-party undo tree and its keybinding remain unchanged.

This configuration deliberately **keeps lazy.nvim and nvim-cmp**. Switching to `vim.pack` or enabling the native `autocomplete` option would duplicate or interfere with existing plugin management and completion behavior. Experimental `ui2` is also not enabled automatically.

## Quick smoke test (Neovim 0.12+)

After `:Lazy sync` has completed, run:

```sh
nvim --headless \
  '+lua assert(vim.fn.has("nvim-0.12") == 1)' \
  '+lua assert(vim.fn.exists(":DiffTool") == 2)' \
  '+lua assert(vim.fn.maparg("<leader>U", "n") ~= "")' \
  '+qa'
```

For interactive verification, test both undo-tree mappings, open a file in a supported language and check LSP/completion, then try `:DiffTool` with two existing paths.

The plugin revisions are not pinned by a lockfile in this repository; `:Lazy sync` resolves and installs the currently configured plugin graph.
