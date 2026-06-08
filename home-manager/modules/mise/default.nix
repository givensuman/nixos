{ lib, ... }: {
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  xdg.configFile."mise/config.toml" = {
    source = lib.mkForce ./mise/config.toml;
  };

  home.sessionVariables = {
    GOPATH = "$HOME/.go";
  };
}
