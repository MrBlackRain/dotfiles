local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>" },
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
    },
  },
}

M.lspsaga = {
  plugin = true,
  n = {
    -- Find the symbol's definition
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "Lspsaga find symbols definition" },
    -- Code action
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "Lspsaga code action" },
    -- Peek definition
    ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", "Lspsaga peek definition" },
    -- Go to definition
    ["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "Lspsaga go to definition" },
    -- Hover Doc
    ["<leader>hd"] = { "<cmd>Lspsaga hover_doc<CR>", "Lspsaga hover doc" },
  },
  v = {
    -- Code action
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "Lspsaga code action" },
  },
}

return M
