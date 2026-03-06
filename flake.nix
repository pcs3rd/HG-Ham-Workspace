{
  description = "nix-config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Bitfocus Companion modules
    companion.url = "github:pcs3rd/bitfocus-companion-flake";
    nixos-generators.url = "github:nix-community/nixos-generators";

  };

  outputs = {
    self,
    nixpkgs,
    impermanence,
    disko,
    companion,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    nixosConfigurations = {
      ham = nixpkgs.lib.nixosSystem {
        # A basic Ham Radio machine that attempts to be as stateless as possible. 
        specialArgs = {inherit inputs outputs;};
        modules = [
            disko.nixosModules.disko
            # Base config for intel macbook. This isn't an intel macbook
            #./nix/base/intel-macbook.nix
            ./nix/base/desktop.nix
            # This is a community machine. It rememembers nothing but /home, and some system state things. No more. 
            ./nix/disk/impermanence.nix
            # User 
            ./nix/users/generic-user.nix
            # packages and services
            ./nix/alacarte/boot/systemd-boot.nix
            ./nix/alacarte/desktops/cosmic.nix
            ./nix/alacarte/services/docker.nix
            ./nix/alacarte/services/tailscale.nix
            ./nix/alacarte/software/firefox.nix
            ./nix/alacarte/software/ham.nix
            {
              disko.devices.disk.system.device = "/dev/sda";
              networking.hostName = "ham";
              nixpkgs.hostPlatform = "x86_64-linux";
            }
        ];
      };
    };
  };
}

