return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
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
}
