{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;  
  };

  services.displayManager = {
    sessionPackages = [ pkgs.niri ];
    defaultSession = "niri";

    autoLogin.enable = true;
    autoLogin.user = "viniciusith";
  };

  programs.niri.enable = true;
}

