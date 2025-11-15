{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/niri/system.nix
  ];

  # Boot configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Enable garbage collection
      # auto-optimise-store = true;
    };
    # Automatic garbage collection
    # gc = {
    # 	automatic = true;
    # 	dates = "weekly";
    # 	options = "--delete-older-than 7d";
    # };
  };

  networking = {
    hostName = "desknix";
    networkmanager.enable = true;
    # Enable firewall
    # firewall = {
    # 	enable = true;
    # 	allowedTCPPorts = [ ];
    # 	allowedUDPPorts = [ ];
    # };
  };

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.enable = true;

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
  };

  services.openssh.enable = true;
  services.printing.enable = true;

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
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Programs
  programs = {
    firefox.enable = true;
    git.enable = true;
    bash.completion.enable = true;
    gamemode.enable = true;
    xwayland.enable = true;
  };

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  users.users.viniciusith = {
    isNormalUser = true;
    description = "ViniciusIth";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "video"
      "audio"
      "lp"
    ];
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
