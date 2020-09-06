{ config, pkgs, ... }:
{
  environment.etc."xdg/termite/config" = { 
      text = builtins.readFile ./config;
      #mode = "0440";
  };
}
