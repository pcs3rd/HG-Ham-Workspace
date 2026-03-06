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
      hg-ham1 = nixpkgs.lib.nixosSystem {
        # A basic Ham Radio machine that attempts to be as stateless as possible. 
        specialArgs = {inherit inputs outputs;};
        modules = [
            # Base config for intel macbook.
            ./nix/base/intel-macbook.nix
            # This is a community machine. It rememembers nothing but /home, and some system state things. No more. 
            ./nix/disko/impermanence.nix
            # User 
            ./nix/user/generic-user.nix
            # packages and services
            ./nix/alacarte/boot/systemd-boot.nix
            ./nix/alacarte/desktops/cosmic.nix
            ./nix/alacarte/services/docker.nix
            ./nix/alacarte/services/tailscale.nix
            ./nix/alacarte/software/firefox.nix
            ./nix/alacarte/software/ham.nix
            {
              networking.hostName = "hg-ham1";
              disko.devices.disk.system.device = "/dev/sda";
            }
        ];
      };
    };
  }

