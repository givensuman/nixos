{ pkgs, inputs, ... }:
{
  imports = [
    ./modules/cosmic/default.nix
    ./modules/fish/default.nix
    ./modules/gh/default.nix
    ./modules/neovim/default.nix
    ./modules/opencode/default.nix
    ./modules/wallpapers/default.nix
    ./modules/bat.nix
    ./modules/bottom.nix
    ./modules/distrobox.nix
    ./modules/eza.nix
    ./modules/firefox.nix
    ./modules/fzf.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/lazygit.nix
    ./modules/mise.nix

    inputs.catppuccin.homeModules.catppuccin
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "given";
    homeDirectory = "/home/given";
  };

  programs.home-manager.enable = true;

  programs.fd.enable = true;
  home.packages = with pkgs; [
    delve
    ripgrep
    zoxide
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}
