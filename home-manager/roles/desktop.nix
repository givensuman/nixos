{ inputs, ... }:
{
  imports = [
    ../modules/bat.nix
    ../modules/bottom.nix
    ../modules/distrobox.nix
    ../modules/eza.nix
    ../modules/firefox.nix
    ../modules/fzf.nix
    ../modules/ghostty.nix
    ../modules/git.nix
    ../modules/helix.nix
    ../modules/lazygit.nix

    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };
}
