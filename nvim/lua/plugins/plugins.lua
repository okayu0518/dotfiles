-- Telescopeのインストールと設定
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "github/copilot.vim",
    lazy = false,
  },

  -- add nvim-neo-tree settings
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 26,
      },
    },
  },
}
