-- FIX: debbuging actualy not working

-- local mason_registry = require "mason-registry"
-- local js_debug_adapter = mason_registry.get_package "js-debug-adapter"

local dbg_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter"
-- local dbg_path = js_debug_adapter:get_package()

local opts = {
  debugger_path = dbg_path,
  debugger_cmd = { "js-debug-adapter" },
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "node-terminal",
  },
}
require("dap-vscode-js").setup(opts)
local dap = require "dap"
for _, adapter in ipairs { "pwa-node", "node-terminal" } do
  dap.adapters[adapter] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "js-debug-adapter", -- As I'm using mason, this will be in the path
      args = { "${port}" },
    },
  }
end
for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      name = "yarn run dev",
      type = "node-terminal",
      -- type = "pwa-node",
      request = "launch",
      command = "yarn run dev",
      console = "integratedTerminal",
    },
    {
      name = "chrome",
      type = "chrome",
      request = "launch",
      url = "http://localhost:3000",
    },
  }
end
-- TODO: launch.json not working

-- Loads .vscode/launch.json files if available
local json5 = require "json5"
require("dap.ext.vscode").json_decode = json5.parse
require("dap.ext.vscode").load_launchjs()
-- require("dap.ext.vscode").load_launchjs(nil, {
--   ["pwa-node"] = { "typescript" },
--   ["node"] = { "typescript" },
-- })
