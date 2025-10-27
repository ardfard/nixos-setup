{ config, pkgs, ... }:

{
  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,1";
      
      # Input configuration
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "ctrl:swapcaps";
        kb_rules = "";
        
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };
      
      # General settings
      general = {
        gaps_in = 1;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # Decoration
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };
      
      # Animations
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      # Dwindle layout
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      
      # Gestures
      gestures = {
        workspace_swipe = "off";
      };
      
      # Window rules
      windowrule = [
        "float, ^(pavucontrol)$"
        "float, ^(blueman-manager)$"
        "float, ^(nm-connection-editor)$"
        "float, ^(chromium)$"
        "float, ^(thunar)$"
        "float, ^(file_progress)$"
        "float, ^(confirm)$"
        "float, ^(dialog)$"
        "float, ^(download)$"
        "float, ^(notification)$"
        "float, ^(error)$"
        "float, ^(splash)$"
        "float, ^(confirmreset)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
      ];
      
      # Key bindings
      bind = [
        # Basic window management
        "SUPER, Q, exec, kitty"
        "SUPER, C, killactive,"
        "SUPER, M, exit,"
        "SUPER, E, exec, ${pkgs.xfce.thunar}/bin/thunar"
        "SUPER, V, togglefloating,"
        "SUPER, D, exec, wofi --show drun"
        "SUPER, K, exec, wofi --show keys"
        "SUPER, P, pseudo,"
        "SUPER, J, togglesplit,"
        
        # Move focus
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        
        # Move windows
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"
        
        # Switch workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        
        # Move to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        
        # Special workspace
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"
        
        # Resize windows
        "SUPER, T, submap, resize"
        "SUPER, escape, submap, reset"
        
        # Screenshots
        ", Print, exec, grimblast copy area"
        "SHIFT, Print, exec, grimblast copy screen"
        "SUPER, Print, exec, grimblast save area"
        "SUPER SHIFT, Print, exec, grimblast save screen"
        
        # Media keys
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        
        # Lock screen
        "SUPER, L, exec, swaylock"
        
        # Fullscreen
        "SUPER, F, fullscreen, 1"
        
        # Toggle all floating
        "SUPER, SHIFT, F, exec, hyprctl dispatch workspaceopt allfloat"
        
        # Move window to center
        "SUPER, G, exec, hyprctl dispatch movewindowpixel exact 50% 50%"
      ];
      
      # Resize submap
      binde = [
        "SUPER, left, resizeactive, -20 0"
        "SUPER, right, resizeactive, 20 0"
        "SUPER, up, resizeactive, 0 -20"
        "SUPER, down, resizeactive, 0 20"
      ];
      
      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:274, movewindow"
        "SUPER, mouse:275, resizewindow"
      ];
      
      # Startup applications
      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "hypridle"
      ];
    };
  };
}
