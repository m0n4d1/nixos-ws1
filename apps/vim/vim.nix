{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (vim_configurable.customize {
      name = "vim";
      vimrcConfig = {
        customRC = builtins.readFile ./.vimrc;
        vam.pluginDictionaries = [
          { names = [
              "ale"
              "indentLine"
              "nerdtree"
              "vim-one"
              "vim-surround"
              "vim-commentary"
              "vim-nix"
              "vim-airline"
              "vim-airline-themes"
              "vim-signify"
            ]; } 
        ];
      };
    })
  ];
}
