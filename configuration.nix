# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./apps/vim/vim.nix
      ./apps/tmux/tmux.nix
      ./apps/termite/termite.nix
      ./apps/zsh/zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };
  

  # nixpkgs.config.allowUnfree = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.resolvconf.dnsExtensionMechanism = false;
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
    time.timeZone = "Australia/Brisbane";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      gimp
      # libreoffice
      dmenu
      firefox
      git
      htop
      networkmanagerapplet
      termite
      wget 
      which
      pciutils
      fontforge
    ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.xserver.layout = "us";
    services.xserver.xkbOptions = "caps:swapescape";
    services.xserver.videoDrivers = [ "amdgpu" ];
    services.xserver.deviceSection = ''
      Option "TearFree" "true"
    '';
    services.xserver.xrandrHeads = [
      {
        output = "HDMI-A-0";
        primary = true;
        monitorConfig = ''
          option "DPMS" "false"
          option "PreferredMode" "3840x2160_60.00"
        '';
      }
    ];
    services.xserver.windowManager.xmonad = {
      config = builtins.readFile ./xmonad/xmonad.hs;
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hpkgs: [           # Open configuration for additional Haskell packages.
        hpkgs.xmonad-contrib             # Install xmonad-contrib.
        hpkgs.xmonad-extras              # Install xmonad-extras.
        hpkgs.xmonad                     # Install xmonad itself.
        hpkgs.xmonad-wallpaper
      ];
    };
    services.xserver.desktopManager.default      = "none";
    services.xserver.desktopManager.xterm.enable = false;
    services.xserver.windowManager.default       = "xmonad";

  # Enable touchpad support.
    services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.anthony = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ]; # Enable ‘sudo’ for the user.
      createHome = true;
      uid = 1000;
      home = "/home/anthony";
      group = "users";
    };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

