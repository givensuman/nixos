# https://mynixos.com/home-manager/options/programs.eza
{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false; # use fish-eza plugin
  };

  catppuccin.eza = {
    enable = true;
    accent = "blue";
  };
}
