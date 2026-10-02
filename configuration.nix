# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Steam via dedicated module
  programs.steam.enable = true;

  # Enable KVM / QEMU virtualization and Virt-Manager GUI
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore"; # Prevents the systemd emergency mode boot crash loop
    };
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
    ghfetch # github fetch
    zigfetch
    fastfetch
    cmatrix
    hollywood
    lolcat
    lsd
    krita
    mousepad
    gitg
    abiword
    vlc
    atril
    audacity
    alpaca
    bleachbit
    conky
    jetbrains.rider
    jetbrains.clion
    jetbrains.pycharm
    jetbrains.webstorm
    jetbrains.datagrip
    jetbrains.dataspell
    jetbrains.phpstorm
    jetbrains-toolbox
    kdePackages.kate
    mariadb
    python3
    renpy
    godot_4-mono        # <-- Swapped from godot_4_7 to enable C#/Mono support out-of-the-box
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
    catfish
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
    dbeaver-bin
    teams-for-linux
    pomodoro
    translatelocally
    nano
    pcsx2
    ppsspp
    retroarch-full
    aseprite
    popsicle
    supertuxkart
    ruffle
    lutris
    mame
    dsda-doom
    dsda-launcher
    dosbox
    drawpile
    viewnior
    brave
    nicotine-plus
    putty
    rustdesk
    teamviewer
    tor
    tor-browser
    transmission_4-gtk
    transmission-remote-gtk
    wireshark
    wireshark-cli
    tshark
    termshark
    hydra
    thc-hydra
    hydra-cli
    hydralauncher
    zenmap
    audacious
    audacious-plugins
    jellyfin-web
    jellyfin-tui
    jellyfin-desktop
    pulseaudioFull
    qmmp
    obsidian
    diskscan
    disktui
    fetchutils
    grub2_efi
    tint2
    cpupower-gui
    cutecom
    terminator
    enlightenment.terminology
    virtualbox
    virtualboxHeadless
    updatecli
    zip
    kdePackages.ark
    kdePackages.filelight
    picom
    playonlinux
    weather
    redshift
  ];

  # List services that units want to enable:
  services.openssh.enable = true;
  networking.firewall.enable = true;

  system.copySystemConfiguration = true;
  system.stateVersion = "26.05";

  # PostgreSQL Service
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  # MariaDB Background Service
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        bind-address = "127.0.0.1";
      };
    };
  };

  # Enable display server and KDE Plasma cleanly
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
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

  # Enable AppImage executables
  programs.appimage = {
    enable = true;
    binfmt = true;
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