{ outputs, inputs, lib, config, pkgs, options, modulesPath, ... }:{

  nix.settings.trusted-users = [ "root" ];


  users.mutableUsers = false;
  users.users = {
    root = {
      hashedPasswordFile = "/stateful/p/root";
    };
    user = {
      isNormalUser = true;
      home = "/home/user";
      description  = "Hacker's Guild";
      uid = 1000; 
      extraGroups = [ "docker" "networkmanager" "storage" "wireshark" "dialout" ]; 
      hashedPasswordFile = "/stateful/p/user";
    };
  };
  programs.wireshark.dumpcap.enable = true;
  programs.wireshark.enable = true;
}

