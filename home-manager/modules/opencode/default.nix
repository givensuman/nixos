# https://mynixos.com/home-manager/option/programs.opencode
{ pkgs, ... }: {
  home.packages = [ pkgs.opencode ];
  catppuccin.opencode.enable = true;

  xdg.configFile."opencode" = {
    source = ./opencode;
    recursive = true;
  };
}
