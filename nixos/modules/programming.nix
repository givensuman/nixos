# Everything related to programming goes here.
{ pkgs, ... }:
let
  languages = with pkgs; [
    bun
    deno
    go
    gopls
    golangci-lint
    golangci-lint-langserver
    nodejs
    pipx
    python3
    rustc
  ];
in
{
  environment.variables = {
    GOPATH = "$HOME/.go";
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      vimPlugins.markdown-preview-nvim
    ];
  };

  # :checkhealth
  environment.systemPackages =
    languages
    ++ (with pkgs; [
      # copilot.nvim
      copilot-language-server

      # conform.nvim
      nixfmt-rfc-style
      prettier
      markdown-toc
      markdownlint-cli2
      shellcheck
      shfmt
      rust-analyzer

      # nvim-treesitter
      tree-sitter

      # sidekick.nvim
      tmux

      # Snacks.image
      imagemagick
      tectonic

      # Snacks.picker
      sqlite

      # ...
      luajit
      luajitPackages.rocks-nvim
      statix
    ]);
}
