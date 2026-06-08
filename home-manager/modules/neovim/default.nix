# https://mynixos.com/home-manager/option/programs.neovim
{ pkgs, ... }:
{
  home.packages = [ pkgs.neovim ];
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
