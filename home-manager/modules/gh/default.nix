{ lib, ... }:
{
  programs.gh.enable = true;

  xdg.configFile."gh/config.yml" = {
    source = lib.mkForce ./gh/config.yml;
  };
  xdg.configFile."gh/hosts.yml".source = ./gh/hosts.yml;
}
