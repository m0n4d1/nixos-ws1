{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ tmux ];
  programs.tmux = {  
    enable = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    extraConfig = builtins.readFile ./.tmux.conf;
    # terminal = "screen-256color";
    baseIndex = 1;
    clock24 = true;
  };
}
