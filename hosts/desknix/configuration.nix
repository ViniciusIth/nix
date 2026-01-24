{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/niri/system.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;

      edk2-uefi-shell = {
        enable = true;
        sortKey = "z_edk2";
      };

      windows = {
        "windows" = let
          boot-drive = "FS2";
        in {
          title = "Windows 11";
          efiDeviceHandle = boot-drive;
          sortKey = "y_windows";
        };
      };
    };
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  powerManagement.enable = true;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
      persistent = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      persistent = true;
      options = "--delete-older-than 30d";
    };
  };

  networking = {
    hostName = "desknix";
    networkmanager.enable = true;
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
  '';

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.enable = true;

  # Auto mount hd
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  security.polkit.enable = true;
  # Allow udisks2 to mount devices without authentication
  # for users in the "wheel" group.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount" ||
           action.id == "org.freedesktop.udisks2.encrypted-unlock-system" ||
           action.id == "org.freedesktop.udisks2.encrypted-unlock") &&
           subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  time.timeZone = "America/Sao_Paulo";

  # Graphics & Bluetooth
  hardware.graphics.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Audio configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.openssh.enable = true;
  services.printing.enable = true;
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.epkowa];
  };
  services.tuned.enable = true;
  services.upower.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font"];
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
      };
    };
  };

  services.transmission = {
    enable = true;
    settings = {
      download-dir = "${config.services.transmission.home}/Downloads";
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    ghostty
    nvidia-vaapi-driver

    # terminal utilities
    btop
    file
    tree
    unzip
    bitwarden-desktop
    lm_sensors

    docker-compose
    xwayland-satellite
    pulseaudio
    quickemu
    qemu

    transmission_4-qt
    (ventoy.override {
      defaultGuiType = "qt5";
      withQt5 = true;
    })
    caligula
  ];

  virtualisation.docker = {
    enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Programs
  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh.enable = true;
    gamemode.enable = true;
    xwayland.enable = true;
  };

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-qt5-1.1.05"
  ];
  networking.firewall.enable = false;

  users.users.viniciusith = {
    isNormalUser = true;
    description = "ViniciusIth";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "video"
      "audio"
      "scanner"
      "lp"
      "plugdev"
    ];
    shell = pkgs.zsh;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # DO NOT CHANGE this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
