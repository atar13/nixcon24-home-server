{ config, pkgs, ... }:

let
  hostname = "my_home_server";

  username = "my_user";

  jellyfinDomain = "jellyfin.local";
  jellyfinPort = 8096;
in 
{
  imports =
    [ 
      # !!! IMPORTANT !!!
      # You need this hardware-configuration.nix file.
      # When installing NixOS it will be automically generated at "/etc/nixos/hardware-configuration.nix".
      #
      # You can generate this with the nixos-generate-config command. 
      # Note that it will overwrite /etc/nixos/hardware-configuration.nix if it's already there.
      ./hardware-configuration.nix
    ];

  # Set hostname based on our hostname variable defined at the top
  networking.hostName = hostname;

  # Enable SSH to remotely access the server
  services.openssh = {
    enable = true;
    settings = {
      # don't allow ssh logins via root user
      PermitRootLogin = "no";
    };
  };

  # Enable Jellyfin to start automatically
  services.jellyfin = {
    enable = true;
    # Automatically allows jellyfin's port through the firewall
    openFirewall = true;
  };

  # Setup NGINX
  services.nginx = {
    enable = true; 
    virtualHosts.${jellyfinDomain} = {
      locations."/" = {
        # forward port 8096 where jellyfin runs on
        proxyPass = "http://127.0.0.1:${jellyfinPort}";
      };
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user named after our username variable above
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}