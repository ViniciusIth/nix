{ config, pkgs, lib, ...}

{
    home.packages = with pkgs; [
    ];

    programs.yazi = {
        enable = true;
        
    }

    xdg.configFile."yazi" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/nixos-dotfiles/config/yazi";
        recursive = true;
    };
}
