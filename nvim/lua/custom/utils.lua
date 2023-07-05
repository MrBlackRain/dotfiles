local M = {}

--- @param ... table
--- @return table
M.merge_arrays = function (...)
  local target = {}
  for _, value in ipairs(arg) do
    vim.list_extend(target, value)
  end
  return target
end

return M
