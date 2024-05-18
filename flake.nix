{
  description = "neovim with preset config in a nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    inherit (nixpkgs) lib;
  in {
    packages.${system}.default = (import ./neovim {inherit pkgs;}).nvim-arst;
    apps.${system}.default = {
      type = "app";
      program = lib.getExe (import ./neovim {inherit pkgs;}).nvim-arst;
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        stylua
        selene
        lua-language-server

        alejandra
        statix
        deadnix
        nil
      ];
      formatter = pkgs.alejandra;
    };
  };
}
