{ config, pkgs, ... }: {
	home.username = "viniciusith";
	home.homeDirectory =  "/home/viniciusith";
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
		};
	};

	home.packages = with pkgs; [
		neovim
		yazi
	];
}
