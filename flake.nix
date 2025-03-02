{
  description = "A personalized configuration for neovim using nix. Ensures dependencies for enabled plugins.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      deps = with pkgs; [
        go
        cargo
        clang
        nodejs_23
        unzip
        luarocks
        fzf
        ripgrep
        ghostscript
        mermaid-cli
        tectonic
        tetex
        kitty
        wezterm
        ghostty
        fd
        lua5_1
        sqlite
        lazygit
      ];
    in
    {
      # Provide an installable package
      defaultPackage.${system} = pkgs.buildEnv {
        name = "nvim-nix";
        paths = deps;
      };

      # Provide a development shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = deps;
      };
    };
}
