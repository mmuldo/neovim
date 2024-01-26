{
  plugins = builtins.foldl' (acc: elem: acc // elem) {} (
    map (file: import file) [
      ./treesitter.nix
      ./telescope.nix
      ./neo-tree.nix
      ./lualine.nix
      ./lsp.nix
      ./completions.nix
      ./none-ls.nix
    ]
  );
}
