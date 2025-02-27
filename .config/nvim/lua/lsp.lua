-- LSP config

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local capabilities = {}

local lsp_status = require('lsp-status')

lsp_status.config {
  status_symbol = "",
  indicator_ok = "",
  indicator_errors = "",
}

lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = false } 
    vim.cmd("Prettier")
  end, bufopts)


  vim.keymap.set('n', '<leader>p', function()
    vim.lsp.buf.format { async = false }
    vim.cmd("Prettier")
    vim.api.nvim_command('write')
  end, bufopts)

  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.buf.inlay_hint(bufnr, true)
  -- end
end

vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format { async = true } end, {})

local lsp_flags = {}

require('lspconfig')['ts_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require('lspconfig')['gopls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

-- require('lspconfig')['eslint'].setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
-- }

-- require("rust-tools").setup {
--   server = {
--     on_attach = on_attach
--   }
-- }
-- 
-- vim.api.nvim_create_user_command('ExpandRustMacro', function() require("rust-tools").expand_macro.expand_macro() end, {})

vim.g.rustaceanvim = {
	server = {
		on_attach = on_attach,

		default_settings = {
			['rust-analyzer'] = {
				check = {
					command = "clippy"
				},

				procMacro = {
					enable = true
				},

				cargo = {
					features = "all",

					buildScripts = {
						enable = true
					},


					procMacro = {
						enable = true
					}
				}
			}
		}
	}
}

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

-- require('lspconfig')['rust_analyzer'].setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
--     -- Server-specific settings...
--     settings = {
--       ["rust-analyzer"] = {
--         procMacro = {
--           enable = true
--         },
--         cargo = {
--           buildScripts = {
--             enable = true
--           },
--           features = "all",
--           checkOnSave = {
--             allTargets = true
--           },
--           procMacro = {
--             enable = true
--           }
--         }
--       }
--     }
-- }

require('lspconfig')['marksman'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

require('lspconfig')['gopls'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}



require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "rust",
    "terraform",
    "hcl",
    "javascript",
    "typescript",
    "tsx",
    "query",
    "make",
    "markdown"
  },

  auto_install = true,

  highlight = {
    -- set to enable = true to use treesitter for highlighting
    enable = true,
  },

	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			node_decremental = "V"
		}
	},

  playground = {
    enable = true
  }
}

require('gruvbox').setup {
  italic = {
    strings = false,
    operators = false,
    comments = false
  },

  overrides = {
    ["@function.builtin"] = { fg = GruvboxFg1 },
    ["@function.builtin"] = { fg = GruvboxFg1 },
    ["@function.call"] = { fg = GruvboxFg1 }
  }
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = { ['<C-u>'] = false },
    },
  },
}

require("telescope").load_extension("ui-select")

local telescope = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<C-p>', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

vim.api.nvim_create_user_command('Rg', function() print('To search use "<leader>fg" in normal mode') end, {})

local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<C-n>'] = cmp.mapping({
      i = function(fallback)
          if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
              cmp.complete()
          end
      end
    }),
    ['<C-p>'] = cmp.mapping({
        i = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end
    }),
    ['<CR>'] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
  }),
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  }
}

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })

local prettier = require("prettier")

prettier.setup {
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
}
