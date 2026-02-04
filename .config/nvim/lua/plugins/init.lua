return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },

 {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
 }, 

 {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
 },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
  -- {
  --   "powerman/vim-plugin-ruscmd"
  -- },
  --
 {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "yaml",
        "python",
        "toml",
        "markdown",
        "bash",
  		},
  	},
  },
 -- {
 --    "Exafunction/codeium.vim",
 --    lazy = false,
 -- },
}
