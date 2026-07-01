{ pkgs, ... }:
let
  languages = with pkgs; [
    bun
    deno
    go
    gopls
    golangci-lint
    golangci-lint-langserver
    nodejs_latest
    odin
    pipx
    python3
    rustc
  ];

  # derived from :checkhealth
  lazyvim_dependencies = with pkgs; [
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

  environment.systemPackages =
    with pkgs;
    [
      neovim
      vscode
    ]
    ++ languages
    ++ lazyvim_dependencies;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
