# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Import Home Manager NixOS module
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."reb" = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Reb";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ]; # To open virt-manager without typing sudo every single time, user must belong to the libvirtd group.
    packages = with pkgs; [];
  };

  # Home Manager Configuration for "reb"
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.reb = { pkgs, ... }: {
    home.stateVersion = "26.05";
    home.enableNixpkgsReleaseCheck = false; # Mutes version mismatch warning

    # Declaratively manage user files and dotfiles
    home.file = {
      # Links ~/.conkyrc to the file stored in your nixos-config repository
      ".conkyrc".source = ./dotfiles/conkyrc;
      # Links ~/.config/awesome to your cloned repository in dotfiles/AwesomeWM
      ".config/awesome".source = ./dotfiles/AwesomeWM;
    };

    # Declarative Git identity
    programs.git = {
      enable = true;
      settings.user = {
        name = "rebel-doomer";
        email = "rebeldomaker@icloud.com";
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Steam via dedicated module
  programs.steam.enable = true;

  # Enable KVM / QEMU virtualization and Virt-Manager GUI
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # System fonts configuration
  fonts.packages = with pkgs; [
    ubuntu-sans
    ubuntu-sans-mono
    ubuntu-classic
    hack-font
    font-awesome
  ];

  xdg = {
    icons.fallbackCursorThemes = [ "BreezeX-RoséPine" ];
  };

  environment.variables = {
    XCURSOR_THEME = "BreezeX-RoséPine";
    XCURSOR_SIZE = "24";
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    kitty
    git
    github-cli
    github-desktop
    doas
    ranger
    btop
    htop
    lynx
    tealdeer
    clamav
    clamtk
    cpufetch
    hyfetch
    freshfetch
    honeyfetch
    ipfetch
    gitfetch
    ghfetch
    zigfetch
    fastfetch
    cmatrix
    hollywood
    lolcat
    krita
    mousepad
    gitg
    abiword
    vlc
    atril
    audacity
    bleachbit
    conky
    jetbrains.rider
    jetbrains.clion
    jetbrains.pycharm
    jetbrains.webstorm
    jetbrains.datagrip
    jetbrains.dataspell
    jetbrains.phpstorm
    kdePackages.kate
    mariadb
    python3
    renpy
    godot_4_7
    thonny
    vscodium
    arduino-ide
    arduino-cli
    telegram-desktop
    discord
    vesktop
    alacritty
    lua
    dracula-theme
    dracula-icon-theme
    tmux
    tmuxPlugins.dracula
    sl
    xfce4-terminal
    mysql-workbench
    prismlauncher
    minecraftia
    rose-pine-cursor
    gzdoom
    freedoom
    polybarFull
    polybar-pulseaudio-control
    flameshot
    gitkraken
    claude-code
    claude-monitor
    chromium
    rofi
    gimp
    lazygit
    lua5
    spotify
    spotifyd
    spotifycli
    spotify-qt
    spotify-player
    dotnet-sdk_11
    dmenu
    windowmaker
    i3
    jwm
    xfwm4
    icewm
    awesome
    docker
    docker-client
    qemu_full
    qemu_kvm
    qemu-utils
    qemu-user
    qemu-python-utils
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = true;

  system.copySystemConfiguration = true;
  system.stateVersion = "26.05";

  ### === Consolidated Services === ###

  # Enable display server and AwesomeWM
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true; # Keeps XFCE available as a fallback
    displayManager.lightdm.enable = true;

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # Package manager for Lua modules
        luadbi-sqlite3 # Database access if needed
      ];
    };
  };

  # Ollama & Local AI
  services.ollama = {
    enable = true;
    package = pkgs.ollama;
    loadModels = [
      "llama3.2:3b"
      "deepseek-r1:1.5b"
      "demodllc/demod-nix-assistant:8b"
    ];
  };

  # Open WebUI interface for Ollama
  services.open-webui = {
    enable = true;
    openFirewall = true;
  };

  # Core System Services
  services.tuned.enable = true;
  services.fstrim.enable = true;
  services.upower.enable = true;
  services.gvfs.enable = true;

  # Printing & Network Device Discovery
  services.ipp-usb.enable = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # PipeWire Audio Stack
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Shell (fish setup)
  programs.fish.enable = true;

  # Security & System Performance
  security.rtkit.enable = true;
  security.sudo-rs.enable = true;

  # Local File Sharing
  programs.localsend.enable = true;

  # Global Session Variables for X11 / GTK
  environment.sessionVariables = {
    GTK_CSD = "0";
    GDK_SCALE = "1";
  };
}