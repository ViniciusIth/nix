{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "MediaMini";
            }
            {
              id = "Volume";
            }
            {
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Kanagawa";
      general = {
        avatarImage = "/home/viniciusith/Pictures/profile.gif";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = false;
        name = "Brasilia, DF";
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = true;
        directory = "/home/viniciusith/Pictures/wallpapers/";
        randomEnabled = true;
      };
      dock = {
        enabled = false;
      };
    };
  };
}
