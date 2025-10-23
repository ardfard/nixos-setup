{
  description = "ardfard NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };
  
  outputs = { self, nixpkgs, ... }@inputs: {
    modules = {
      ./configuration.nix
    }
  }
}
