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
        keybinds {
          unbind "Ctrl n"
          unbind "Ctrl h"
          unbind "Ctrl s"
          unbind "Ctrl o"
        }
      '';
      settings = {
        theme = "catppuccin-mocha";
      };
    };
    catppuccin.zellij.enable = true;
  };

  # https://github.com/nix-community/NixOS-WSL/issues/1074
  # None of the below works
  # services.xserver.enable = lib.mkForce false;
  # systemd.targets."display-manager".wantedBy = lib.mkForce [ ];
  # systemd.user.services.dbus-session = lib.mkForce {
  #   wantedBy = [ "default.target" ];
  #   serviceConfig = {
  #     Type = "dbus";
  #     BusName = "org.freedesktop.DBus";
  #     ExecStart = "${pkgs.dbus}/bin/dbus-daemon --session --nofork --nopidfile --syslog-only";
  #   };
  # };
  # environment.sessionVariables = {
  #   DISPLAY = ":0";
  # };
}
