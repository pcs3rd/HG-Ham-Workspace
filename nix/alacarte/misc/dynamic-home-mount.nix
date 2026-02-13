{ outputs, inputs, lib, config, pkgs, options, modulesPath, ... }:{
  fileSystems."/home/user" =
    { device = "/dev/disk/by-label/USER_DATA"; # this is important!
      fsType = "ext4";
      options = [ "noatime" "noexec" ];
    };

}

