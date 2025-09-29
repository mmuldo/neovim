return {
  'stevearc/oil.nvim',
  opts = {

  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
  config = function(_, opts)
    require("oil").setup(opts)

    vim.keymap.set("n", "<leader>0", "<CMD>Oil<CR>")
  end
}
