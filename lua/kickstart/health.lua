--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
--
--]]

local check_version = function()
  local verstr = string.format('%s.%s.%s', vim.version().major, vim.version().minor, vim.version().patch)
  if not vim.version.cmp then
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.cmp(vim.version(), { 0, 12, 0 }) >= 0 then
    vim.health.ok(string.format("Neovim version is: '%s' (0.12 features available)", verstr))
  else
    vim.health.error(string.format("Neovim '%s' is too old. nvim-treesitter/main requires 0.12 or newer", verstr))
  end
end

local check_external_reqs = function()
  -- Git for lazy.nvim, ripgrep for Telescope, and build tools required by
  -- the nvim-treesitter main branch (including tree-sitter-cli >= 0.26.1).
  for _, exe in ipairs { 'git', 'rg', 'curl', 'tar', 'tree-sitter' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end

  -- Presence alone is not sufficient: nvim-treesitter/main needs CLI 0.26.1+.
  if vim.fn.executable 'tree-sitter' == 1 then
    local output = vim.fn.system { 'tree-sitter', '--version' }
    local major, minor, patch = output:match '(%d+)%.(%d+)%.(%d+)'
    if vim.v.shell_error ~= 0 or not major then
      vim.health.warn 'Could not verify the tree-sitter CLI version (requires 0.26.1+)'
    elseif vim.version.cmp({ tonumber(major), tonumber(minor), tonumber(patch) }, { 0, 26, 1 }) < 0 then
      vim.health.error(('tree-sitter CLI %s.%s.%s is too old (requires 0.26.1+)'):format(major, minor, patch))
    else
      vim.health.ok(('tree-sitter CLI %s.%s.%s meets 0.26.1+'):format(major, minor, patch))
    end
  end

  -- A C compiler is required to build Tree-sitter parsers.
  if vim.fn.executable 'cc' == 1 or vim.fn.executable 'gcc' == 1 or vim.fn.executable 'clang' == 1 or vim.fn.executable 'cl' == 1 then
    vim.health.ok 'Found a C compiler for Tree-sitter parsers'
  else
    vim.health.error 'No C compiler found for Tree-sitter parser builds'
  end

  -- Optional utilities used by other plugins and install flows.
  for _, exe in ipairs { 'make', 'unzip' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found optional executable: '%s'", exe))
    else
      vim.health.info(string.format("Optional executable not found: '%s'", exe))
    end
  end

  return true
end

return {
  check = function()
    vim.health.start 'kickstart.nvim'

    vim.health.info [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!]]

    vim.health.info('System Information: ' .. vim.inspect(vim.uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
