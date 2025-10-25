{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];
  # Home Manager needs a bit of information about the path and
  # to manage your home directory. This is done by setting
  # `home.username` and `home.homeDirectory`.
  home.username = "ardfard";
  home.homeDirectory = "/home/ardfard";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager at any time by setting
  # this value. See the Home Manager release notes for a
  # list of state changes that break configuration
  # compatibility.
  home.stateVersion = "25.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Development tools
    git
    vim
    curl
    wget
    
    # Terminal and shell
    kitty
    zsh
    
    # Wayland and Hyprland related
    wayland
    wayland-utils
    hyprland
    foot
    wofi
    
    # Hyprland ecosystem
    waybar
    swaylock
    grimblast
    cliphist
    hypridle
    brightnessctl
    wl-clipboard
    
    # File manager
    thunar
    
    # Network
    networkmanagerapplet
  ];

  # Environment variables
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable shell integration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Ardin Fardiansyah";
    userEmail = "ardfard@ngublag.com"; # Replace with your actual email
  };

  # Kitty terminal configuration
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    settings = {
      font_family = "JetBrains Mono";
      font_size = 12;
      background_opacity = "0.9";
    };
  };

}
