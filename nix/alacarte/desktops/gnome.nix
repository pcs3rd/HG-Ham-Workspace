{ inputs, outputs, lib, pkgs, ... }:{
    environment.defaultPackages = lib.mkForce [
        pkgs.gnomeExtensions.dash-to-dock
        pkgs.gnomeExtensions.clipboard-indicator
        pkgs.gnomeExtensions.tray-icons-reloaded
        pkgs.gnome-tweaks
        
    ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
