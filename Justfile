user := "given"
host := "gandalf"

# Show this help
default:
    @just --list

_go-sudo:
  @sudo --validate

# Rebuild system and home configurations
rebuild: _go-sudo _nix-switch _hm-switch _stow

# Build and activate new system configuration
[group('nixos')]
_nix-switch args='':
    sudo nixos-rebuild --flake '#{{ host }}' switch {{ args }}

# Build system configuration as a dry-run
[group('nixos')]
_nix-build args='':
    sudo nixos-rebuild --flake '#{{ host }}' build {{ args }}

# Build and activate, with rollback on failure
[group('nixos')]
_nix-test args='':
    sudo nixos-rebuild --flake '#{{ host }}' test {{ args }}

# Switch to previous generation
[group('nixos')]
_nix-rollback:
    sudo /run/current-system/bin/switch-to-configuration switch

# Build documentation
[group('nixos')]
_nix-docs:
    nixos-rebuild --flake '#{{ host }}' build --build-llvm-tools

# Update flake inputs
[group('nixos')]
_nix-update:
    nix flake update

# Clean nix store
[group('nixos')]
_nix-clean:
    sudo nix-collect-garbage -d

# Show current system generations
[group('nixos')]
_nix-generations:
    nix-env -p /nix/var/nix/profiles/system --list-generations

# Build and activate new home configuration
[group('home-manager')]
_hm-switch:
  home-manager switch --flake .#{{ user }}@{{ host }}

# Build home configuration as a dry-run
[group('home-manager')]
_hm-build:
  home-manager build --flake .#{{ user }}@{{ host }}

# Show current home generations
[group('home-manager')]
_hm-generations:
  home-manager generations --flake .#{{ user }}@{{ host }}

# Stow config files
_stow:
  #!/usr/bin/env bash
  for dir in ./stow/*/; do
      pkg=$(basename "$dir")

      stow -d ./stow -t "$HOME" -R "$pkg"
  done
