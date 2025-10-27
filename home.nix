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
    xfce.thunar
    
    # Network
    networkmanagerapplet
    
    # Fonts for Waybar icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    font-awesome
    material-design-icons
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

  # Font configuration
  fonts.fontconfig.enable = true;

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

  # NixVim configuration
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Basic settings
    globals.mapleader = " ";
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
    };

    # Keymaps
    keymaps = [
      {
        mode = "n";
        key = "<leader>pv";
        action = "<cmd>Ex<cr>";
        options = { desc = "Open file explorer"; };
      }
      {
        mode = "n";
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<cr>";
        options = { desc = "Toggle undo tree"; };
      }
      {
        mode = "n";
        key = "<leader>y";
        action = "\"+y";
        options = { desc = "Copy to system clipboard"; };
      }
      {
        mode = "v";
        key = "<leader>y";
        action = "\"+y";
        options = { desc = "Copy to system clipboard"; };
      }
    ];

    # Plugins
    plugins = {
      # Theme
      catppuccin = {
        enable = true;
        flavour = "mocha";
        transparentBackground = true;
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          nixd.enable = true;
        };
      };

      # Completion
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
        };
      };

      # Treesitter
      treesitter = {
        enable = true;
        indent = true;
        folding = true;
        nixvimInjections = true;
      };

      # Telescope
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      # Git
      gitsigns = {
        enable = true;
        signs = {
          add = { text = "+"; };
          change = { text = "~"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; };
        };
      };

      # Which-key
      which-key = {
        enable = true;
        registrations = {
          "<leader>f" = "Find";
          "<leader>g" = "Git";
        };
      };

      # Undotree
      undotree = {
        enable = true;
        keymaps = {
          toggle = "<leader>u";
        };
      };
    };
  };

}
