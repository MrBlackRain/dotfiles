local null_ls = require "null-ls"
local config = require "custom.languages.python.config"

local sources = {}

for _, value in ipairs(config.formatters) do
  table.insert(sources, null_ls.builtins.formatting[value])
end
for _, value in ipairs(config.linters) do
  table.insert(sources, null_ls.builtins.diagnostics[value])
end

return sources

