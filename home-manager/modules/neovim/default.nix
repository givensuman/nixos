# https://mynixos.com/home-manager/option/programs.neovim
{ pkgs, ... }:
{
  home.packages = [ pkgs.neovim ];
  home.file."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
