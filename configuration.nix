# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Explicitly set NIX_PATH so nixos-rebuild automatically reads from my git repository
  nix.nixPath = [
    "nixos-config=/home/reb/NixOS/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  ];

  # Bootloader setup: Switch to GRUB and keep 10 generations
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # configure NixOS to store temporary files in RAM instead of writing them to the drive. 
  # This speeds up application loading and reduces unnecessary wear-and-tear on the SSD
  # don't need to manually micromanage this because tmpfs is completely dynamic
  # Linux handles memory prioritization automatically.
  # tmpfs Doesn't Pre-allocate RAM
  # When you enable boot.tmp.useTmpfs = true
  # it doesn't instantly carve out a chunk of the RAM (like 50%) and lock it away. 
  # It only uses RAM as files are actually written into /tmp. 
  # If /tmp is empty or only holding small temporary files, it uses virtually zero RAM.
  # Linux Automatically Prioritizes Active Apps
  # The Linux kernel's memory manager constantly monitors what is happening
  # Active apps (IDEs, browsers, etc) get immediate priority for physical RAM.
  # If /tmp files aren't being actively used, or if system memory gets tight, 
  # the kernel automatically pushes inactive data into zram or swap file to free up physical RAM for heavy applications.
    boot.tmp.useTmpfs = true; 

  # Automatic Garbage Collection & Generation Management
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 120d"; # todo tweak how long
  };

  # Declarative 32GB Swap File
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32768; # 32GB in Megabytes
    }
  ];

  networking.hostName = "nixos"; # Define hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8"; 
  
  # todo configure languages (LT, US, DK) and english colemak layout
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

  # Configure keymap in X11, good for guaranteed fallback
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Limit Systemd Journal Log Size
  services.journald.extraConfig = ''
  SystemMaxUse=4G
'';

  # Configure console keymap
  # this is where you set the layout for the virtual console/TTY (the plain text screen you see if you press Ctrl+Alt+F3, or before a graphical desktop loads).
  console.keyMap = "us"; # todo consider colemak layout later

  # Define a user account.
  users.users."reb" = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Reb";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages and permit the specific insecure electron version
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-41.10.7" # todo find a better work arond later
  ];

  # Enable Steam via dedicated module
  programs.steam.enable = true;

  # System fonts configuration
  fonts.packages = with pkgs; [
    ubuntu-sans
    ubuntu-sans-mono
    ubuntu-classic
    hack-font
    font-awesome
    noto-fonts
    liberation_ttf
    starship # Ensure starship binary is available system-wide
  ];

  xdg = {
<<<<<<< HEAD
    icons.fallbackCursorThemes = [ "BreezeX-RoséPine" ];
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-kde # Assuming Plasma 6 since you use desktopManager.plasma6
      ];
      config.common.default = "*";
    };
=======
    icons.fallbackCursorThemes = [ "BreezeX-RoséPine" ]; # todo choose something more compatible/standard
>>>>>>> origin/main
  };

  environment.variables = {
    XCURSOR_THEME = "BreezeX-RoséPine"; # todo choose something more compatible/standard
    XCURSOR_SIZE = "24";
  };

  # Declaratively generate the Conky configuration file at /etc/conky/conky.conf
  # GONE LOL bye conky

  # Declaratively generate btop configuration with Dracula theme
  environment.etc."btop/btop.conf".text = ''
    color_theme = "dracula"
    theme_background = False
    update_ms = 2500
    proc_sorting = "cpu lazy"
    proc_reversed = False
    proc_tree = False
    proc_colors = True
    proc_gradient = True
    proc_per_core = False
    proc_mem_bytes = True
    proc_cpu_graphs = True
    check_temp = True
    temp_scale = "celsius"
    base_10_kilobytes = False
    show_cpu_freq = True
    clock_format = "%H:%M"
    background_update = True
    show_battery = True
    selected_battery = "Auto"
    log_level = "WARNING"
  '';

  # Auto-start Conky via user desktop autostart entry
  # note Conky is obsolete x11 trash.
  # todo migrate to wayland alternative to conky
  # services.xserver.desktopManager.plasma6.enable = true; # ensures KDE session
  
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    # kitty
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
    # conky
    # php
    nginx
    jetbrains.rider
    jetbrains.webstorm
    jetbrains.phpstorm
    jetbrains.datagrip
    jetbrains.dataspell
    jetbrains.pycharm
    jetbrains.clion
    jetbrains.goland
    jetbrains.ruby-mine
    jetbrains.rust-rover
    kdePackages.kate
    kdePackages.okular
    # thinkpad-scripts
    drawio
    appimage-run
    appimageupdate
    mariadb
    python3
    renpy
    godot_4-mono
    thonny
    fortran-fpm
    fortran-language-server
    lolcode
    go
    vscodium
    javascript-typescript-langserver
    jellyfin-desktop
    arduino-ide
    arduino-cli
    telegram-desktop
    discord
    vesktop
    alacritty
    gcc
    dracula-qt5-theme
    dracula-theme
    dracula-icon-theme
    tmux
    tmuxp
    tmuxai
    tmuxPlugins.dracula
    sl
    catfish
    cowsay
    neo-cowsay
    ponysay
    xfce4-terminal
    mysql-workbench  
    prismlauncher
    minecraftia
    rose-pine-cursor
    gzdoom
    freedoom
    chocolate-doom
    crispy-doom
    flameshot
    gitkraken
    claude-code
    claude-monitor
    chromium
    gimp
    lua5
    zx
    mujs
    nodejs
    nodejsInstallManuals
    spotify
    spotifyd
    spotifycli
    spotify-qt
    spotify-player
    dotnet-sdk_11
    dbeaver-bin
    pomodoro-gtk
    openpomodoro-cli
    translatelocally
    nano
    dolphin-emu
    pcsx2
    ppsspp-qt
    retroarch-full
    aseprite
    popsicle
    supertuxkart
    ruffle
    lutris
    mame
    dsda-doom
    dsda-launcher
    eureka-editor
    dosbox
    drawpile
    viewnior
    brave
    libreoffice
    nicotine-plus
    putty
    rustdesk
    teamviewer
    tor
    tor-browser
    transmission_4-gtk
    transmission-remote-gtk
    wireshark
    tshark
    termshark
    hydra
    thc-hydra
    hydra-cli
    hydralauncher
    zenmap
    audacious
    audacious-plugins
    icloudpd
    jellyfin-web
    jellyfin-tui
    jellyfin-desktop
    java-language-server
    pulseaudioFull
    musicfree-desktop
    strawberry
    beep
    beets
    libmusicbrainz
    terminalmap
    obsidian
    diskscan
    disktui
    fetchutils
    grub2_efi
    cpupower-gui
    cutecom
    terminator
    enlightenment.terminology
    updatecli
    zip
    kdePackages.ark
    kdePackages.filelight
    kdePackages.kdevelop
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    picom
    playonlinux
    mupen64plus
    weather
    tgpt
    wine64
    wine
    notepad-next
    wine-wayland
    eza
    bat
    ripgrep
    fd
    duf
    ncdu
    nnn
    starship
  ];

  # enable ssh
  services.openssh.enable = true;
  
  # enable firewall
  networking.firewall.enable = true;

  system.copySystemConfiguration = true;
  system.stateVersion = "26.05"; # todo research

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

  # virtualization/docker enable
  virtualisation.docker.enable = true;

  # Enable display server and KDE Plasma cleanly
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true; # todo choose a new DM, maybe

  # Auto-start Conky on login
  # services.xserver.displayManager.sessionCommands = ''
  #  conky -c /etc/conky/conky.conf &
  #'';

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

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

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
      support32Bit = true; # steam compatibility, i guess
    };
  };

  # Enable AppImage executables
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # enables plocate, a fast file-search utility
  # sets up background service to index entire hard drive every x hour(s)
  # to instantly locate files using commands like locate <filename>.
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "hourly";
  };

  # flatpak
  services.flatpak.enable = true;

  # Automatically hard-links identical files in Nix store. 
  # If multiple installed packages/apps share the exact same files, 
  # Nix replaces duplicate copies on drive with a single hard link to save disk space.
  nix.settings.auto-optimise-store = true;

  # automatic loading of latest microcode updates for Intel CPU during boot. 
  # applies vital security patches, stability fixes, performance improvements directly from Intel.
  hardware.cpu.intel.updateMicrocode = true;

  # Shell (fish setup, aliases, hyfetch, and starship initialization)
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    if status is-interactive
        hyfetch
    end

    alias build-nix "sudo nixos-rebuild switch -I nixos-config=/home/reb/NixOS/configuration.nix"
    alias update-nix "sudo nixos-rebuild switch --upgrade -I nixos-config=/home/reb/NixOS/configuration.nix"

    starship init fish | source
  '';

  # security
  security.rtkit.enable = true;
  security.sudo-rs.enable = true;

  programs.localsend.enable = true;

  environment.sessionVariables = {
    XCURSOR_THEME = "BreezeX-RoséPine";
    XCURSOR_SIZE = "24";
    GTK_CSD = "0";
    GDK_SCALE = "1";
    QT_QPA_PLATFORM = "wayland";
  };
}