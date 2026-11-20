# Neovim configuration (native-first)

Personal Neovim **0.12+** configuration based on Kickstart, with **native Neovim APIs prioritized over plugins**. The upstream Kickstart project also uses `vim.pack`, but this is a selective migration, not a full overwrite of local customizations.

## Native replacements

| Previously installed | Replacement | Familiar behavior |
| --- | --- | --- |
| `lazy.nvim` | `vim.pack` | Native install/update + `nvim-pack-lock.json` |
| `mbbill/undotree` | `:packadd nvim.undotree` | `<leader>u` and `<leader>U` open `:Undotree` |
| `ts-comments.nvim` | Built-in `gc` and `gcc` | `<leader>cc`, `Ctrl-/`, `gco`, `gcO`, `gcA` |
| `nvim-cmp` and companion sources | `vim.lsp.completion`, core popup menu and `vim.snippet` | `Ctrl-Space`, `Ctrl-n/p`, `Enter`, `Ctrl-l/h` |
| `nvim-osc52` | `vim.g.clipboard = 'osc52'` on SSH | Existing `+y` clipboard workflow |
| `fidget.nvim` | Neovim's built-in LSP progress support | Native progress display |

Removed `otter.nvim` (no longer used by completion) and `beacon.nvim` (optional cursor decoration). The native `:DiffTool` is also loaded. Unused/optional Kickstart example files do not install anything.

## Retained plugins and why

Telescope still supplies your fuzzy-file/search/LSP picker workflow, Harpoon supplies persistent jump lists, GitSigns supplies hunks and Git signs, mini.nvim supplies enhanced text objects/surroundings, and Mason installs language tools automatically. Rustaceanvim retains Rust-specific integrations. Your local llama.cpp model picker, ToggleTerm virtual-environment behavior, Monokai colors, Lualine statusline, and custom indent guides are retained.

These features do not have an equivalent built into 0.12 that preserves your existing workflow with a simpler configuration.

**Differences from the previous setup:** Native LSP completion does not automatically offer the same collection of VS Code/friendly snippets, path, and embedded-language completion sources as `nvim-cmp`. It can expand snippets returned by an LSP server. Rust analyzer completion remains **manual via Ctrl-Space** to avoid the performance issues previously guarded in this configuration. The old bespoke `gb` / `gbc` block-comment operators were not recreated; `gc` covers line/range commenting. The former custom cursor beacon is removed.

## Install / upgrade (CachyOS or Arch)

```sh
sudo pacman -Syu neovim tree-sitter-cli base-devel ripgrep curl tar
nvim --version | head -1
tree-sitter --version
```

`nvim-treesitter/main` requires `tree-sitter-cli` **0.26.1+**, `curl`, `tar`, and a C compiler.

After merging, `git pull` into your Neovim config directory. **Back up** the old config and `stdpath('data')` before the first start. The new `vim.pack.add()` setup downloads its declared packages on first launch; it does not delete the old `stdpath('data')/lazy` cache automatically.

Inside Neovim, run:

```vim
:checkhealth kickstart
:checkhealth vim.pack
:TSUpdate
:lua vim.pack.update(nil, { offline = true })
```

To update installed packages with a reviewable diff:

```vim
:lua vim.pack.update()
```

The first successful launch writes `nvim-pack-lock.json`; **commit that lockfile** to make future installations reproducible.

## Smoke tests

After the first package installation finishes:

```sh
nvim --headless \
  '+lua assert(vim.fn.has("nvim-0.12") == 1)' \
  '+lua assert(vim.fn.exists(":DiffTool") == 2)' \
  '+lua assert(vim.fn.exists(":Undotree") == 2)' \
  '+lua assert(vim.fn.maparg("<leader>u", "n") ~= "")' \
  '+lua assert(vim.fn.maparg("<C-Space>", "i") ~= "")' \
  '+qa'
```

Then verify interactively: `<leader>sf` and `<leader>sg` (Telescope), `<leader>u` (undo tree), `<leader>cc`/`gcc` (comments), a buffer with a language server attached (native completion), `<leader>a`/`Ctrl-e` (Harpoon), `<leader>tt` (terminal), `<leader>m` (llama), and Rust analyzer. For remote SSH sessions, test clipboard copying inside your actual terminal/tmux setup.

## Validation scope

Configuration review and GitHub diff validation are separate from runtime validation. This PR has not yet been executed on a machine running Neovim 0.12; make sure the smoke tests pass before merging.
