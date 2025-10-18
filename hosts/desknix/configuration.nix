{ 
    config, 
    lib, 
    pkgs, 
    ... 
}: {
	imports = [
        ./hardware-configuration.nix
    ];
	
    # Boot configuration
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
		# Add timeout for boot menu
		# systemd-boot.configurationLimit = 10;
	};
    boot.kernelPackages = pkgs.linuxPackages;  # Use stable kernel for better NVIDIA support


    # NVIDIA configuration
  #   services.xserver.videoDrivers = [ "nvidia" ]; 
  #   hardware.nvidia = {
  #       modesetting.enable = true;
  #       powerManagement.enable = true; # Disable for laptops
  #       nvidiaSettings = true;
  #       package = config.boot.kernelPackages.nvidiaPackages.production;
		#
		# powerManagement.finegrained = true;  # Better power management
		# forceFullCompositionPipeline = true;  # Reduce screen tearing
  #   };

	# hardware.opengl = {
	# 	enable = true;
	# 	driSupport32Bit = true;
	# 	extraPackages = with pkgs; [
	# 		nvidia-vaapi-driver
	# 		vaapiVdpau
	# 		libvdpau-va-gl
	# 	];
	# };

    nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
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
	
	time.timeZone = "America/Sao_Paulo";
	
  	# Graphics & Bluetooth
	hardware.graphics.enable = true;
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;  # Ensure Bluetooth starts on boot
	};
	services.blueman.enable = true;

    # X11 configuration
	services.xserver = {
		# enable = true;
		# autoRepeatDelay = 200;
		# autoRepeatInterval = 35;
		# windowManager.qtile.enable = true;
		# displayManager.lightdm.enable = true;

        xkb = {
            layout = "us";
            variant = "intl";
        };
	};

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
				monospace = [ "JetBrainsMono Nerd Font" ];
				sansSerif = [ "Noto Sans" ];
				serif = [ "Noto Serif" ];
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

	# Programs
	programs = {
		firefox.enable = true;
		git.enable = true;
		bash.completion.enable = true;
		gamemode.enable = true;
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

