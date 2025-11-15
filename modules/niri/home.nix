{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_WAYLAND = "1";
  };

  systemd.user.services = {
    polkit-agent = {
      Unit = {
        Description = "KDE Polkit Authentication Agent";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    mako = {
      Unit = {
        Description = "Mako Notification Daemon";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.mako}/bin/mako";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    nm-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };

  xdg.configFile."niri" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/niri";
    recursive = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    swaybg
    mako
    networkmanagerapplet
    kdePackages.polkit-kde-agent-1
  ];
}
