{
  pkgs,
  username,
  hostname,
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

  # Set Nix daemon to use lower scheduling priority.
  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";

  # Enable hardware-accelerated graphics.
  hardware.graphics.enable = true;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.editor = false;
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Silent Boot
    # https://wiki.archlinux.org/title/Silent_boot
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    # https://github.com/NixOS/nixpkgs/pull/108294
    initrd.verbose = false;
  };

  # Enable networking.
  networking.networkmanager.enable = true;
  networking.hostName = "${username}.${hostname}";
  hardware.bluetooth.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
