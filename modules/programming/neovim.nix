{
  pkgs,
  ...
}:
let
  # derived from :checkhealth
  lazyvim_dependencies = with pkgs; [
    # copilot.nvim
    copilot-language-server
    # conform.nvim
    nixfmt
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
    ghostscript
    mermaid-cli
    # Snacks.picker
    sqlite
    # ...
    luarocks
    luajit
    luajitPackages.rocks-nvim
    statix
  ];
in
{
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
    ]
    ++ lazyvim_dependencies;
}
