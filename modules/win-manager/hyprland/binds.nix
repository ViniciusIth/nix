{hostname ? "default"}: let
  # Import the special app script
  special_app = ../../../scripts/special_app.sh;
  special_workspace = appName: workspaceName: let
    checkCommand = "hyprctl clients | grep '${appName}'";
  in "${checkCommand} && hyprctl dispatch togglespecialworkspace ${workspaceName} || ${appName}";

  # Helper function to create bindings
  mkBind = mod: key: action: "${mod}, ${key}, ${action}";

  # Common bindings shared across all hosts
  commonBinds = {
    # Terminal
    "SUPER, T" = "exec, ghostty";

    # File manager
    "SUPER, E" = "exec, ghostty";

    # # Application launcher
    # "SUPER, Super_l" = "exec, killall wofi || wofi --normal-window --show drun --allow-images";

    # Window management
    "SUPER, Q" = "killactive,";
    "SUPER, M" = "fullscreen, 1";
    "SUPER, V" = "togglefloating,";
    "SUPER, P" = "layoutmsg, swapwithmaster master";

    # Focus movement (vim-style)
    "SUPER, h" = "movefocus, l";
    "SUPER, l" = "movefocus, r";
    "SUPER, k" = "movefocus, u";
    "SUPER, j" = "movefocus, d";

    # Special workspaces
    "SUPER, S" = "togglespecialworkspace, magic";
    "SUPER SHIFT, S" = "movetoworkspace, special:magic";

    # Screenshot
    # ", Print" = "exec, grim -g \"$(slurp)\" - | wl-copy";
  };

  # Workspace switching binds
  workspaceBinds = builtins.listToAttrs (
    builtins.concatLists (
      builtins.genList (
        i: let
          ws = toString (i + 1);
        in [
          {
            name = "SUPER, ${toString (i + 1)}";
            value = "workspace, ${ws}";
          }
          {
            name = "SUPER SHIFT, ${toString (i + 1)}";
            value = "movetoworkspace, ${ws}";
          }
        ]
      )
      10
    )
  );

  # Mouse bindings (bindm)
  mouseBinds = {
    "SUPER, mouse:272" = "movewindow";
    "SUPER, mouse:273" = "resizewindow";
  };

  # Repeated bindings (binde)
  repeatingBinds = {
    # Workspace navigation
    "SUPER SHIFT, L" = "workspace, e+1";
    "SUPER SHIFT, R" = "workspace, e-1";
  };

  # Host-specific bindings
  hostSpecificBinds = {
    "lapnix" = {
      # Laptop-specific bindings
    };

    "desknix" = {
      # Desktop-specific bindings
    };
  };

  # Host-specific repeating bindings (binde)
  hostSpecificRepeatingBinds = {
    "lapnix" = {
      # Laptop-specific repeating bindings
    };

    "desknix" = {
      # Desktop-specific repeating bindings
    };
  };
in {
  # Regular bindings
  bind = commonBinds // workspaceBinds // (hostSpecificBinds.${hostname} or {});

  # Mouse bindings
  bindm = mouseBinds;

  # Repeating bindings
  binde = repeatingBinds // (hostSpecificRepeatingBinds.${hostname} or {});
}
