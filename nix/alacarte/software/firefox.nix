{ inputs, outputs, lib, pkgs, ... }:{
  environment.systemPackages = with pkgs; [
	firefox
    browsh
  ];
}