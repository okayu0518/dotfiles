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
}
