local null_ls = require "null-ls"
local config = require "custom.languages.typescript.config"

local sources = {}

for _, value in ipairs(config.formatters) do
  table.insert(sources, null_ls.builtins.formatting[value])
end

return sources

