{ config, pkgs, ... }: 

{
	home.username = "viniciusith";
	home.homeDirectory =  "/home/viniciusith";
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
		};
	};

	home.file.".config/nvim" = {
		source = ./config/nvim;
		recursive = true;
	};
	home.packages = with pkgs; [
		neovim
		yazi
		ripgrep
		nil
		nixpkgs-fmt
		nodejs
	];
}
