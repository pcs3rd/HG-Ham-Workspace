{ outputs, inputs, lib, config, pkgs, options, modulesPath, ... }:{

  nix.settings.trusted-users = [ "root" ];


  users.mutableUsers = false;
  users.users = {
    root = {
      description  = "Hackers's Guild Root";
      hashedPasswordFile = "/stateful/p/root";
    };
    user = {
      isNormalUser = true;
      home = "/home/operator";
      description  = "Hacker's Guild";
      uid = 1000; 
      extraGroups = [ "docker" "networkmanager" "storage" ]; 
      hashedPasswordFile = "/stateful/p/user";
    };
  };
}

