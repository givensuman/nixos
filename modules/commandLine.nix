{
  pkgs,
  username,
  ...
}:
{
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  # Launch Fish shell for interactive Bash sessions.
  # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  home-manager.users.${username} = {
    # https://mynixos.com/home-manager/options/programs.bat
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

    # https://mynixos.com/home-manager/options/programs.bottom
    programs.bottom.enable = true;
    catppuccin.bottom.enable = true;

    # https://mynixos.com/home-manager/options/programs.eza
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = false; # use fish-eza plugin
    };
    catppuccin.eza = {
      enable = true;
      accent = "blue";
    };

    home.packages = with pkgs; [
      ripgrep
      zoxide
    ];

    # https://mynixos.com/home-manager/options/programs.fzf
    programs.fzf.enable = true;
    catppuccin.fzf.enable = true;

    # https://mynixos.com/home-manager/options/programs.fd
    programs.fd.enable = true;
  };
}
