{ pkgs, ... }:
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow real-time priority for audio applications.
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "-";
      value = "99999";
    }
  ];

  environment.systemPackages = with pkgs; [
    # Requests
    wget
    curl
    # Archival
    unzip
    zip
    p7zip
    gnutar
    stow
    # Runners
    gnumake
    just
    # Essentials for life not to suck
    gcc
    git
    less
    util-linux
    wl-clipboard
    nix-search-tv
    # Internals I've never used...
    libcap
    strace
    lsof
  ];

  # Provide suggestions of packages to install
  # when a command is not found.
  programs.command-not-found.enable = true;

  # Set Nix daemon to use lower scheduling priority.
  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";

  # Enable hardware-accelerated graphics.
  hardware.graphics.enable = true;

  security.sudo-rs.enable = true;
}
