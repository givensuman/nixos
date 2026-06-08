Since starting to use Linux 2-3 years ago I've done a lot of distro-hopping. Eventually I got tired of reinstalling and configuring a system every other week so I created a system of scripts and services to automate the process.

Then I discovered atomic SilverBlue and built my own operating system on top of it, which was nice because the configuration was declarative and almost any setup could be achieved with a `rebase`, not a reinstall. However, as a container image this means all changes to my system needed to run through a remote `docker-buildx` job.

So I bootstrapped the image within itself and got `bootc` to be able to rebase to itself locally. This worked okay for hacking, but I realized I was just reinventing NixOS. So now I use NixOS. Thanks for coming to my TED talk.

### Usage

Usage of this system is centered around a "world" directory at `$HOME/world`. That convention stems from Alpine Linux but I've since discovered it's pretty common among NixOS users. This directory holds the flake and dotfiles, as well as a [Justfile](./Justfile) for abstracting away Nix commands and scripts for managing the system, accessible via the `world` wrapper [function](./nixos/modules/world.nix).

### Uhm, actually

Yes, much of this is not the "Nix" way of doing things. I tinker with my shell orders of magnitude more often than I do my hardware, so I don't put as much value on the reproducibility side of things.
