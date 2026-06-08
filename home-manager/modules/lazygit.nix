# https://mynixos.com/home-manager/options/programs.lazygit
{
  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      keybinding.universal = {
        universal = {
          scrollUpMain = "<c-b>";
          scrollDownMain = "<c-f>";
        };
      };
    };
  };

  catppuccin.lazygit.enable = true;
}
