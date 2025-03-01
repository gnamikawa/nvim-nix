{
  description = "A personalized configuration for neovim using nix. Ensures dependencies for enabled plugins.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "nvimnix";
      version = "1.0";
      buildInputs = with pkgs; [
        go
        cargo
        neovim
        lazygit
        clang
        nodejs_23
        unzip
        luarocks
      ];
      src = ./.; # No actual build, just dependencies
    };
  };
}
