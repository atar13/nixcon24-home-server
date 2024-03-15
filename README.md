# Set up your own home server with Nix

This repo is from our NixCon NA 2024 presentation, which you can [view here](https://godsped.com/files/nixcon/slides.html).

## Install NixOS

We won't be going over getting a base install setup in too much detail here. [The NixOS Wiki](https://nixos.wiki/wiki/NixOS_Installation_Guide) is a great guide for doing so. This is just the same as installing another Linux distribution from a bootable USB drive. You can download an [Graphical ISO image](https://nixos.org/download/#nixos-iso), [copy it onto a USB drive](https://nixos.org/manual/nixos/stable/#sec-booting-from-usb), boot into it from your computer's BIOS, and follow the graphical installer.

## Load Configuration

**Sample home server configuration is at [`configuration.nix`](./configuration.nix).**

Once you're on a vanilla system, you can start modifying your system configuration.

It's located at `/etc/nixos/configuration.nix` on your system.

You can modify this file or swap in a configuration like the one we provide. We reccomend you iteratively modify this file by changing one thing at a time and rebuilding

### Build the system 

Switch now
```sh
sudo nixos-rebuild switch
```

Switch on next boot
```sh
sudo nixos-rebuild boot
```

### Hardware Configuration

By default, the NixOS installation will autogenerate a `hardware-configuration.nix` at `/etc/nixos/hardware-configuration.nix` which contains hardware specific configuration. 

If for whatever reason you corrupted or deletd this file, you can regenerate it by running `nixos-generate-config`.

# Slides

## nix-shell

If you have Nix installed, enter our Nix shell with the `marp-cli` package installed by running `nix-shell`.

Then run `make` to generate a `slides.html` file.

## Marp VSCode Extension

Install VSCode with the [Marp extension](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode). Open `slides.md` in VSCode and run  "Marp: Export Slide Deck" in the VSCode command pallete (View -> Command Pallete). You can also click the marp preview on the top right of the text window.

## Acknowledgements

Thanks to @Cody Rupp.
