{ inputs, outputs, lib, pkgs, modulesPath, ... }:{
  boot = {
    loader = {
        systemd-boot = {
            enable = true;
            configurationLimit = 2;
        };
    };
    
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "fastboot"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "bgrt_disable=0" 
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };
}