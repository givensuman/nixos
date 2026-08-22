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
      opencode
      helix
      steel
      steel-language-server
    ]
    ++ lazyvim_dependencies;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # home-manager.users.${username} = {
  #   programs.helix = {
  #     enable = true;
  #     settings = {
  #       theme = "catppuccin-mocha";
  #       editor.cursor-shape = {
  #         normal = "block";
  #         insert = "bar";
  #         select = "underline";
  #       };
  #     };
  #     languages.language = [
  #       {
  #         name = "nix";
  #         auto-format = true;
  #         formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
  #       }
  #     ];
  #   };
  # };
}
