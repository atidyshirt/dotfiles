local M = {}

---@class LualineConfig
local default = {
  float = true,
  separator = "square",
  ---@type any
  colorful = true,
  separator_icon = { left = "", right = " " },
  thin_separator_icon = { left = "", right = " " },
}

---@type LualineConfig
M.options = {}

---@param type  "square" | "triangle"
local function make_separator(type)
  if type == "square" then
    M.options.separator_icon = { left = "█", right = "█" }
    M.options.thin_separator_icon = { left = " ", right = " " }
  elseif type == "triangle" then
    M.options.separator_icon = { left = "█", right = "█" }
    M.options.thin_separator_icon = { left = " ", right = " " }
    return
  end
end

M.setup = function(opts)
  M.options = vim.tbl_deep_extend("force", {}, default, opts or default)
  if M.options.float then
    make_separator(M.options.separator)
  end
end

M.setup()

return M
