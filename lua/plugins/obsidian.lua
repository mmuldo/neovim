return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = {
    "BufReadPre " .. vim.fn.expand("~/vaults") .. "**/*",
    "BufNewFile " .. vim.fn.expand("~/vaults") .. "**/*",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/vaults/notes",
      }
    },
    completion = {
      blink = true,
      nvim_cmp = false,
    },
    picker = {
      name = "fzf-lua",
    },
    legacy_commands = false,
  },
  config = function(_, opts)
    require "obsidian".setup(opts)

    vim.keymap.set("n", "<leader>dn", ":Obsidian today<CR>")
    vim.keymap.set("n", "<leader>dy", ":Obsidian yesterday<CR>")

    vim.keymap.set("n", "<leader>td", function()
      require "fzf-lua".grep { search = "- [ ]" }
    end)
  end
}
