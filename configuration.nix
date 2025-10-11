{ config, lib, pkgs, ... }:

{
	imports =
	  [
	    ./hardware-configuration.nix
	  ];
	
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	networking.hostName = "nixmach";
	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
	time.timeZone = "America/Sao_Paulo";
	
	# i18n.defaultLocale = "en_US.UTF-8";
	# console = {
	#   font = "Lat2-Terminus16";
	#   keyMap = "us";
	#   useXkbConfig = true; # use xkb.options in tty.
	# };
	

	services.displayManager.lightdm.enable = true;
	services.xserver = {
		enable = true;
		autoRepeatDelay = 200;
		autoRepeatInterval = 35;
		windowManager.qtile.enable = true;
		# xkb.layout = "us";
		# xkb.options = "eurosign:e,caps:escape";	
	};
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};
	services.openssh.enable = true;
	services.printing.enable = true;

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	environment.systemPackages = with pkgs; [
		vim
		wget
		git
		ghostty
	];

	programs.firefox.enable = true;


	users.users.viniciusith = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		packages = with pkgs; [
			tree
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

