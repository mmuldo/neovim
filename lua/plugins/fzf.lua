return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    vim.keymap.set("n", "<leader>sf", fzf.files)
    vim.keymap.set("n", "<leader>s/", fzf.live_grep_native)
    vim.keymap.set("n", "<leader>sh", fzf.helptags)
    vim.keymap.set("n", "<leader><leader>", fzf.buffers)
  end,
}
