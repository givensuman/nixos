{ lib, ... }:
{
  programs.fish.enable = true;
  catppuccin.fish.enable = true;

  xdg.configFile."fish/config.fish" = {
    source = lib.mkForce ./fish/config.fish;
  };
}
