{ outputs, inputs, lib, config, pkgs, modulesPath, ... }:{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.home-manager.nixosModules.home-manager
    ];

# Security Opts
  security.polkit.enable = true;
  security.rtkit.enable = true;

# This should be in most env's
  environment.systemPackages = with pkgs; [
    nano
    git 
  ];
  
# Networking Opts
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = lib.mkDefault true;

# Enable Microcode Updates
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

# Nix/System Settings
  #system.stateVersion = "25.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Don't allow any user to grab software
  nix.settings.trusted-users = [ "root" ];


# Enable sshd
  services.openssh = {
    enable = true;
  };

# Network
  networking.networkmanager.enable = true;

# Audio
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

# Set TZ
  time.timeZone = "America/New_York";

# Boot Settings
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
}
