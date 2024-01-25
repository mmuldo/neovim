{
  description = "mmuldo's neo(nix)vim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    config = import ./config { inherit pkgs; };

    package = nixvim.legacyPackages.${system}.makeNixvim config;

    module = { ... }: {
      imports = [
        nixvim.nixosModules.nixvim
      ];

      programs.nixvim = {
        enable = true;
      } // config;
    };
  in
  {
    packages.x86_64-linux = rec {
      nvim = package;
      default = nvim;
    };

    nixosModules = rec {
      neovim = module;
      default = neovim;
    };
  };
}
