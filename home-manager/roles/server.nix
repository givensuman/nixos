{ inputs, ... }:
{
  imports = [
    ../modules/git.nix
    ../modules/helix.nix

    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
  };
}
