{ pkgs, inputs, ... }:
{
  imports = [
    ./modules/bat.nix
    ./modules/bottom.nix
    ./modules/distrobox.nix
    ./modules/eza.nix
    ./modules/firefox.nix
    ./modules/fzf.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/lazygit.nix

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
    github-cli # in /stow
    neovim # in /stow
    opencode # in /stow
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
