{
  pkgs,
  lib,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      extraConfig = ''
        unbind "Ctrl n"
        unbind "Ctrl h"
        unbind "Ctrl s"
        unbind "Ctrl o"
      '';
      settings = {
        theme = "catppuccin-mocha";
      };
    };
    catppuccin.zellij.enable = true;
  };

  services.xserver.enable = lib.mkForce false;
  systemd.targets."display-manager".wantedBy = lib.mkForce [ ];
}
