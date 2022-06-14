-- lspconfig
--require'lspconfig'.dartls.setup {
--  cmd = { "dart", "/home/mega/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
--}

-- nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip0 = require('luasnip')
local luasnip = require("luasnip.loaders.from_vscode").lazy_load()

-- better autocompletion experience
vim.o.completeopt = 'menu,menuone,noselect'

cmp.setup({
	snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    
    window = {
       -- completion = cmp.config.window.bordered(),
       -- documentation = cmp.config.window.bordered(),
    },

    -- Format the autocomplete menu
	formatting = {
--      format = lspkind.cmp_format()
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                               " " .. vim_item.kind
            -- set a name for each source
          --  vim_item.menu = ({
          --      luasnip    = "[Luasnip]",
          --      nvim_lsp   = "[LSP]",
          --      cmdline    = "[cmd]",
          --      path       = "[Path]",
          --      buffer     = "[Buf]",
          --      nvim_lua   = "[Lua]",
          --      -- look       = "[Look]",
          --      -- spell      = "[Spell]",
          --      -- calc       = "[Calc]",
          --      -- emoji      = "[Emoji]"
          -- })[entry.source.name]
           return vim_item
     end

	},
	
    mapping = cmp.mapping.preset.insert({
        -- these two not working from me C-p/C-n is & arwos down/up too is 
        --['<C-b>'] = cmp.mapping.scroll_docs(-4),
        --['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        --['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- this causing issue with luasnip lazy_load 
        -- Use Tab and shift-Tab to navigate autocomplete menu
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip0.expand_or_jumpable() then
              luasnip0.expand_or_jump()
            else
              fallback()
            end
          end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
        end,
      
         --confirm the selection   
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },


--    ["<Tab>"] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_next_item()
--      elseif luasnip.expand_or_jumpable() then
--        luasnip.expand_or_jump()
--      elseif has_words_before() then
--        cmp.complete()
--      else
--        fallback()
--      end
--    end, { "i", "s" }),
--
--    ["<S-Tab>"] = cmp.mapping(function(fallback)
--      if cmp.visible() then
--        cmp.select_prev_item()
--      elseif luasnip.jumpable(-1) then
--        luasnip.jump(-1)
--      else
--        fallback()
--      end
--    end, { "i", "s" }),
    
    }),
        
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'cmdline' },
        { name = 'path' },
       -- { name = "look" }, 
       -- { name = "calc" }, 
       -- { name = "spell" },
       -- { name = "emoji" }
    }, {
        { name = 'buffer' }, 
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
  mapping = cmp.mapping.preset.cmdline(), 
  sources = {
     { name = 'buffer' }
   }
 })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
  }, {
        { name = 'cmdline' }
  })
})

cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
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


-- lspconfig
local nvim_lsp = require('lspconfig')
local servers = { 'dartls' }


local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<space>z', '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', opts)

--    -- NOT SURE IS THAT DO SOMETHING OR NOT
--    if client.resolved_capabilities.document_highlight then
--    vim.cmd [[
--        hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--        hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--    ]]
--    vim.api.nvim_create_augroup('lsp_document_highlight', {
--        clear = false
--    })
--    vim.api.nvim_clear_autocmds({
--        buffer = bufnr,
--        group = 'lsp_document_highlight',
--    })
--    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--        group = 'lsp_document_highlight',
--        buffer = bufnr,
--        callback = vim.lsp.buf.document_highlight,
--    })
--    vim.api.nvim_create_autocmd('CursorMoved', {
--        group = 'lsp_document_highlight',
--        buffer = bufnr,
--        callback = vim.lsp.buf.clear_references,
--    })
--    end


end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { 'dartls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

