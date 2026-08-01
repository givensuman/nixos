{ pkgs, inputs, ... }:
{
  imports = [
    ../roles/desktop.nix
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
    github-cli
    neovim
    opencode
    ripgrep
    zoxide
  ];

  home.stateVersion = "26.05";
}
