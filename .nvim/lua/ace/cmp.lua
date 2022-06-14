-- nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

-- better autocompletion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup({
	
    -- Format the autocomplete menu
	formatting = {
        format = lspkind.cmp_format()
--     format = function(entry, vim_item)
--           -- fancy icons and a name of kind
--           vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
--                               " " .. vim_item.kind
--           -- set a name for each source
--           vim_item.menu = ({
--               buffer     = "[Buf]",
--               luasnip    = "[Luasnip]",
--               cmdline    = "[cmd]",
--               path       = "[Path]",
--               nvim_lsp   = "[LSP]",
--               nvim_lua   = "[Lua]",
--              -- look       = "[Look]",
--              -- spell      = "[Spell]",
--              -- calc       = "[Calc]",
--              -- emoji      = "[Emoji]"
--           })[entry.source.name]
--           return vim_item
--     end

	},
	
--    mapping = {
--        ['<C-Space>'] = cmp.mapping.complete(),
--        ['<C-e>'] = cmp.mapping({
--                          i = cmp.mapping.abort(),
--                          c = cmp.mapping.close(),
--        }),
--        -- Use Tab and shift-Tab to navigate autocomplete menu
--        ['<Tab>'] = function(fallback)
--            if cmp.visible() then
--              cmp.select_next_item()
--            elseif luasnip.expand_or_jumpable() then
--              luasnip.expand_or_jump()
--            else
--              fallback()
--            end
--          end,
--        ['<S-Tab>'] = function(fallback)
--            if cmp.visible() then
--              cmp.select_prev_item()
--            elseif luasnip.jumpable(-1) then
--              luasnip.jump(-1)
--            else
--              fallback()
--            end
--        end,
--        ['<CR>'] = cmp.mapping.confirm {
--            behavior = cmp.ConfirmBehavior.Replace,
--            select = true,
--        },
--    },
    
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' }, 
        { name = 'nvim_lua' },
        { name = 'cmdline' },
        { name = 'path' },
       -- { name = "look" }, 
       -- { name = "calc" }, 
       -- { name = "spell" },
       -- { name = "emoji" }
    })
})

-- Set configuration for specific filetype.
 cmp.setup.filetype('gitcommit', {
   sources = cmp.config.sources({
     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
   }, {
     { name = 'buffer' },
   })
 })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline('/', {
   sources = {
     { name = 'buffer' }
   }
 })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline(':', {
   sources = cmp.config.sources({
     { name = 'path' }
   }, {
     { name = 'cmdline' }
   })
 })


-- diagnostic 
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=true})]]

--vim.o.updatetime = 250
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

--vim.diagnostic.config({
--  virtual_text = {
--    prefix = '■', -- Could be '●', '▎', 'x'
--  }
--})


local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
