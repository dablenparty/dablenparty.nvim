local M = {}

---@return boolean is_nvim_11 `true` if this instance of neovim is at least `0.11.0`.
function M.is_nvim_11()
  -- TODO: remove these functions once 0.11 goes stable
  return vim.version().minor >= 11
end

---@return string semver The semantic version string of this neovim instance (e.g. `0.11.0`).
function M.get_semver_string()
  local ver = vim.version()
  return string.format('v%d.%d.%d', ver.major, ver.minor, ver.patch)
end

return M
