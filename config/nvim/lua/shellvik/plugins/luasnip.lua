-- lua/shellvik/plugins/luasnip.lua
return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local luasnip = require("luasnip")

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets",
    })
  end,
  keys = {
    {
      "<Tab>",
      function()
        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          return "<Plug>luasnip-expand-or-jump"
        else
          return "<Tab>"
        end
      end,
      mode = { "i", "s" },
      expr = true,
      silent = true,
    },
    {
      "<S-Tab>",
      function()
        local ls = require("luasnip")
        if ls.jumpable(-1) then
          return "<Plug>luasnip-jump-prev"
        else
          return "<S-Tab>"
        end
      end,
      mode = { "i", "s" },
      expr = true,
      silent = true,
    },
  },
}
