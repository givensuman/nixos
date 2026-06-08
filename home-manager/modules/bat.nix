# https://mynixos.com/home-manager/option/programs.bat
{
  pkgs,
  ...
}:
{
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
    ];
  };

  catppuccin.bat.enable = true;
}
