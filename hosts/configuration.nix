# NixOS configuration and main entry point.
# See configuration.nix(5) man page or `nixos-help`
{
  pkgs,
  inputs,
  username,
  hostname,
  ...
}:
{
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
    nix-search-tv
    # Internals I've never used...
    libcap
    strace
    lsof
  ];

  # Provide suggestions of packages to install
  # when a command is not found.
  programs.command-not-found.enable = true;

  security.sudo-rs.enable = true;

  # Set time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # User account.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  networking.hostName = hostname;

  home-manager.users.${username} = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "26.05";
    };
  };

  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "lavender";
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
