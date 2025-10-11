{ config, pkgs, ... }: 

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
    	nvim = "nvim";
    };
in 
{
    imports = [
        ./modules/neovim.nix
    ];

	home.username = "viniciusith";
	home.homeDirectory =  "/home/viniciusith";
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo I use nixos, btw";
		};
	};

	xdg.configFile = builtins.mapAttrs (name: subpath: {
		source = create_symlink "${dotfiles}/${subpath}";
		recursive = true;
	}) configs;

	home.packages = with pkgs; [
		neovim
		yazi
		ripgrep
		nil
		nixpkgs-fmt
		nodejs
		zig
		tree-sitter
		cargo
	];
}
