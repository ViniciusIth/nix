{pkgs, ...}: {
  programs.niri = {
    enable = true;
  };

  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.polkit-kde-agent-1
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = [
    pkgs.nautilus # Required for GNOME portal file picker
    pkgs.mako # Notification daemon
    pkgs.wlr-randr # Monitor layout utility
    pkgs.wl-clipboard # Clipboard support
    pkgs.swaybg # Simple background program
    pkgs.networkmanagerapplet # For Wi-Fi tray applets
    pkgs.kdePackages.polkit-kde-agent-1
    pkgs.ghostty # terminal
  ];
}
