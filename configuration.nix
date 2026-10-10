# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Explicitly set NIX_PATH so nixos-rebuild automatically reads from your git repository
  nix.nixPath = [
    "nixos-config=/home/reb/NixOS/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

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

  # Define a user account.
  users.users."reb" = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Reb";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
  ];

  xdg = {
    icons.fallbackCursorThemes = [ "BreezeX-RoséPine" ];
  };

  environment.variables = {
    XCURSOR_THEME = "BreezeX-RoséPine";
    XCURSOR_SIZE = "24";
  };

  # Declaratively generate the Conky configuration file at /etc/conky/conky.conf
  environment.etc."conky/conky.conf".text = ''
    conky.config = {
        use_xft = true,
        font = 'DejaVu Sans Mono:size=10',
        xftalpha = 1,
        update_interval = 1,
        total_run_times = 0,
        own_window = true,
        own_window_type = 'desktop',
        own_window_transparent = true,
        own_window_argb_visual = true,
        own_window_argb_value = 50,
        own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
        double_buffer = true,
        minimum_width = 300,
        minimum_height = 600,
        maximum_width = 300,
        draw_shades = false,
        draw_outline = false,
        draw_borders = false,
        draw_graph_borders = false,
        default_color = 'white',
        alignment = 'bottom_left',
        gap_x = 100,
        gap_y = 30,
        no_buffers = true,
        uppercase = false,
        cpu_avg_samples = 2,
        override_utf8_locale = true,
        color1 = '#FFFFFF',
        color2 = '#FFA500',
    };

    conky.text = [[
    $${color2}$$
{font Ubuntu:bold:size=10}SYSTEM $${hr 2}$${font}
    $${color1}Distribution:$$
    $${execi 3600 lsb_release -ds}$$
{color1}Kernel:$$     $${kernel}
    $${color1}Hostname:$$
    $${nodename}$$
{color1}Uptime:$$     $${uptime}

    $${color2}$$
{font Ubuntu:bold:size=10}CPU $${hr 2}$${font}
    $${color1}CPU1 Usage:$$
    $${cpu cpu1}\%$$
{cpubar cpu1}$${color1}CPU2 Usage:$${cpu cpu2}\%$${cpubar cpu2}$${color1}CPU3 Usage:$$     $${cpu cpu3}% $${cpubar cpu3}$${color1}CPU4 Usage: $${cpu cpu4}\%$${cpubar cpu4}
    $${color1}CPU Graph:$$
    $${cpugraph 50,140}      $$
{color2}$${font Ubuntu:bold:size=10}MEMORY$${hr 2}$${font}$${color1}RAM Usage:$$     $${mem} of $${memmax} ($${memperc}%)
    $${color1}RAM Bar:$$
    $${membar}$$
{color1}Free RAM:$$     $${memeasyfree}

    $${color2}$$
{font Ubuntu:bold:size=10}STORAGE $${hr 2}$${font}
    $${color1}Root:$$
    $${fs_used /} of$$
{fs_size /}$${color1}Usage:$${fs_used_perc /}\%$${fs_bar 6,140 /}      $${color2}$${font Ubuntu:bold:size=10}UPDATES$${hr 2}$${font}$${color1}Packages to Update:$$     $${execi 3600 apt list --upgradeable 2>/dev/null | grep -cv 'Listing...'}

    $${color2}$$
{font Ubuntu:bold:size=10}TOP CPU PROCESSES $${hr 2}$${font}
    $${color1}CPU:$$
    $${top name 1}$$
{top cpu 1}\%$${color1}CPU:$${top name 2}$${top cpu 2}\%$${color1}CPU:$$     $${top name 3} $${top cpu 3}\%$${color2}$${font Ubuntu:bold:size=10}TOP RAM PROCESSES$${hr 2}$${font}$${color1}RAM: $${top_mem name 1}$${top_mem mem 1}%
    $${color1}RAM:$$
    $${top_mem name 2}$$
{top_mem mem 2}\%$${color1}RAM:$${top_mem name 3}$${top_mem mem 3}\%      $${color2}$${font Ubuntu:bold:size=10}BATTERIES$${hr 2}$${font}$${color1}Battery 1:$$     $${battery_percent BAT0}% $${battery_bar BAT0}$${color1}Battery 2: $${battery_percent BAT1}\%$${battery_bar BAT1}
    ]];
  '';

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
    conky
    php
    nginx
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
    godot_4-mono
    thonny
    fortran-fpm
    fortran-language-server
    lolcode
    go
    vscodium
    javascript-typescript-langserver
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
    dmenu
    windowmaker
    jwm
    xfwm4
    icewm
    awesome
    dbeaver-bin
    teams-for-linux
    pomodoro
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
    jellyfin-web
    jellyfin-tui
    jellyfin-desktop
    pulseaudioFull
    qmmp
    terminalmap
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
    updatecli
    zip
    kdePackages.ark
    kdePackages.filelight
    picom
    playonlinux
    mupen64plus
    weather
    tgpt
  ];

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
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

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
      support32Bit = true;
    };
  };

  # Enable AppImage executables
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Shell (fish setup and aliases)
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    if status is-interactive
        # Commands to run in interactive sessions can go here
    end

    # Rebuild system using your local repo configuration
    alias build-nix "sudo nixos-rebuild switch -I nixos-config=/home/reb/NixOS/configuration.nix"

    # Upgrade system packages and rebuild using your local repo configuration
    alias update-nix "sudo nixos-rebuild switch --upgrade -I nixos-config=/home/reb/NixOS/configuration.nix"
  '';

  # Security & System Performance
  security.rtkit.enable = true;
  security.sudo-rs.enable = true;

  # Local File Sharing
  programs.localsend.enable = true;

  # Global Session Variables for X11 / GTK
  environment.sessionVariables = {
    XCURSOR_THEME = "BreezeX-RoséPine";
    XCURSOR_SIZE = "24";
    GTK_CSD = "0";
    GDK_SCALE = "1";
  };
}