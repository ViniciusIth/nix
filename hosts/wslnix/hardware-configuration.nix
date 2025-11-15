{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [];

  # Basic filesystem for root - using the actual device from df output
  fileSystems."/" = {
    device = "/dev/sdd";
    fsType = "ext4";
  };

  # No other filesystems needed for WSL - WSL handles the rest

  # No swap in WSL typically
  swapDevices = [];

  # WSL-specific settings
  boot.loader.grub.device = "nodev";
  boot.loader.systemd-boot.enable = false;

  # Use the same CPU microcode setting as the WSL NixOS template
  hardware.cpu.intel.updateMicrocode = lib.mkDefault false;

  # Networking handled by WSL
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
