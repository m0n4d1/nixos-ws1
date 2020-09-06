{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ zsh ];
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" "vi-mode" "colored-man-pages" "command-not-found" "extract" ];
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  users.users.anthony.shell = pkgs.zsh;

}
