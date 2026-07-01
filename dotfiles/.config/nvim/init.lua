local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- for fun
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = {
      theme = "leaves",
      max = 10,
      interval = 100,
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        disable_move = true,
        packages = { enable = false },
        project = { enable = false },
        shortcut = {},
        footer = {},
        header = {
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠉⠉⠉⠙⠻⣅⠀⠈⢧⠀⠈⠛⠉⠉⢻⣿⣿]],
          [[⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⣤⡶⠟⠀⠀⣈⠓⢤⣶⡶⠿⠛⠻⣿]],
          [[⣿⣿⣿⣿⣿⢣⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣀⣴⠶⠿⠿⢷⡄⠀⠀⢀⣤⣾⣿]],
          [[⣿⣿⣿⣿⣡⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣦⣤⣤⡀⠀⢷⡀⠀⠀⣻⣿⣿]],
          [[⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⠛⠶⠛⠃⠈⠈⢿⣿⣿]],
          [[⣿⣿⠟⠘⠀⠀⠀⠀⠀⠀⠀⠀⢀⡆⠀⠀⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠈⣿⣿]],
          [[⣿⠏⠀⠁⠀⠀⠀⠀⠀⠀⠀⢀⣶⡄⠀⠀⠀⠀⠀⠀⣡⣄⣿⡆⠀⠀⠀⠀⣿⣿]],
          [[⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠚⠛⠛⢛⣲⣶⣿⣷⣉⠉⢉⣥⡄⠀⠀⠀⠨⣿⣿]],
          [[⡇⢠⡆⠀⠀⢰⠀⠀⠀⠀⢸⣿⣧⣠⣿⣿⣿⣿⣿⣿⣷⣾⣿⡅⠀⠀⡄⠠⢸⣿]],
          [[⣧⠸⣇⠀⠀⠘⣤⡀⠀⠀⠘⣿⣿⣿⣿⣿⠟⠛⠻⣿⣿⣿⡿⢁⠀⠀⢰⠀⢸⣿]],
          [[⣿⣷⣽⣦⠀⠀⠙⢷⡀⠀⠀⠙⠻⠿⢿⣷⣾⣿⣶⠾⢟⣥⣾⣿⣧⠀⠂⢀⣿⣿]],
          [[⣿⣿⣿⣿⣷⣆⣠⣤⣤⣤⣀⣀⡀⠀⠒⢻⣶⣾⣿⣿⣿⣿⣿⣿⣿⢀⣀⣾⣿⣿]],
        }
      },
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" }
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    pin = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {
      defaults = {
        layout_strategy = "vertical",
      },
      pickers = {
        find_files = {
          previewer = false,
          follow = true,
          hidden = true,
          layout_strategy = "horizontal",
          find_command = { "fd", "--type", "f", "--exclude", ".git" },
        },
        buffers = {
          previewer = false,
        },
      },
    }
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  "itchyny/lightline.vim",
  {
    "cappyzawa/trim.nvim",
    opts = {},
  },
  "tpope/vim-sleuth",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {"williamboman/mason.nvim", opts = {}},
      {"williamboman/mason-lspconfig.nvim", opts = {}},
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {"dcampos/nvim-snippy", opts = {}},
    },
    -- opts = {},
    opts = function (PluginSpec)
      local cmp = require("cmp")
      local snippy = require("snippy")
      local options = {}

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      options.snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end
      }

      options.sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      })

      options.mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snippy.can_expand_or_advance() then
            snippy.expand_or_advance()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif snippy.can_jump(-1) then
            snippy.previous()
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<Enter>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
      }

      return options
    end,
  },
  {
    "notjedi/nvim-rooter.lua",
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      hint_enable = false,
      handler_opts = {
        border = "none",
      },
      wrap = false,
    },
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
  {
    "nacro90/numb.nvim",
    opts = {},
  },
})

vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.vb = true
vim.opt.wrap = false

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme("zenbones")

-- Remap
vim.keymap.set("n", "<space>", ":noh <CR>", {})

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})

-- lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.zls.setup({
  capabilities = capabilities,
})

vim.diagnostic.config({
  signs = false,
})
