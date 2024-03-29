{
  description = "mmuldo's neo(nix)vim config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-parts,
    nixpkgs,
    nixvim,
    ...
  } @ inputs:
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    perSystem = { system, ... }:
    let
      package = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        module = ./config;
      };

      colorschemeToNixvim = colorscheme: {
        name = colorscheme;
        value = package.nixvimExtend { colorschemes.${colorscheme}.enable = true; };
      };

      check = nixvim.lib.${system}.check.mkTestDerivationFromNvim {
        nvim = package;
        name = "nvim-test";
      };
    in
    {
      checks = rec {
        nvim = check;
        default = nvim;
      };

      packages = builtins.listToAttrs (map colorschemeToNixvim [
        "catppuccin"
        "dracula"
        "gruvbox"
        "nord"
        "rose-pine"
        "tokyonight"
      ]) // {
        default = package;
      };
    };
  };
}
