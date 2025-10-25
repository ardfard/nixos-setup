# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # setting up hyprland
  programs = {
    hyprland.enable = true;
    dconf.enable = true;
  };

  services.seatd.enable = true;
  services.dbus = {
    enable = true;
    packages = with pkgs; [ dconf ];
  };

  # Automatically start Hyprland session when logging in via Greetd
  security.pam.services.greetd.enableGnomeKeyring = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ardfard = {
    isNormalUser = true;
    description = "Ardin Fardiansyah";
    group = "ardfard";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      git
      kitty
    ];
  };

  users.groups.ardfard = {
    gid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "ardfard";
  services.greetd = { 
    enable = true;
    settings = rec {
      tuigreet_session = 
        let
          session = "${pkgs.hyprland}/bin/Hyprland";
          tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
        in
        {
          command = "${tuigreet} --time --remember --cmd ${session}";
          user = "ardfard";
        };
      default_session = tuigreet_session;
    };
  };


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim 
     wget
     curl
     lsof

     wayland
     wayland-utils
     hyprland
     foot
     wofi

     thunar
     networkmanagerapplet
  ];

  fileSystems."/mnt/share" = {
    device = "host_share";
    fsType = "9p";
    options = [ "trans=virtio" "version=9p2000.L" "_netdev" "nofail" "rw" "uid=1000" "gid=1000" "dmask=000" "fmask=111"];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${pkgs.hyprland}/bin/Hyprland";
  services.xrdp.openFirewall = true;


  services.qemuGuest.enable = true; 
  # systemd.user.services.spice-vdagent = {
  #   enable = true;
  #   description = "SPICE User Agent";
  #   wantedBy = [  "graphical-session.target" ];
  #   serviceConfig = {
  #      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent";
  #      Restart = "on-failure";
  #   };
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ {from = 1714; to = 1764; } ];
  # networking.firewall.allowedTCPPortRanges = [ {from = 1714; to = 1764; }];
  # networking.firewall.allowedUDPPorts = [ {from = 1714; to = 1764; } ];
  # networking.firewall.allowedUDPPortRanges = [ {from = 1714; to = 1764; }];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
