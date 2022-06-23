{ config, pkgs, ... }:
let hashedPassword = "$6$HYibiGhDN.JgLtw6$cecU7NjfumTUJSkFNFQG4uVgdd3tTPLGxK0zHAwYn3un/V43IUlyVBNKoRMLCQk65RckbD/.AjsLFVFKUUHVA/";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  # Passwords
  users.users.kiana = { inherit hashedPassword; };
  users.users.root = { inherit hashedPassword; };
}
