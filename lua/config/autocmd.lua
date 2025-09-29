local augroup = vim.api.nvim_create_augroup
local MmuldoGroup = augroup("Mmuldo", {})
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "highlight when yanking text",
  group = MmuldoGroup,
  callback = function()
    vim.highlight.on_yank()
  end
})
