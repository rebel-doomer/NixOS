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

    # Declaratively manage user files and dotfiles
    home.file = {
      # Links ~/.conkyrc to the file stored in your nixos-config repository
      ".conkyrc".source = ./dotfiles/conkyrc;
    };

    # Declarative Git identity
    programs.git = {
      enable = true;
      userName = "rebel-doomer";
      userEmail = "rebeldomaker@icloud.com";
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
  }; # Fixed: closed environment.variables block properly

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    jetbrains.phpstorm
    kdePackages.kate
    mariadb
    python3
    renpy
    godot_4
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
    # polybar
    polybarFull
    flameshot
    
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

  ### === Consolidated Services === ###

  # Enable display server
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true;

    # TODO window manager (qtile) setup
    # windowManager.i3.enable = true;
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
  services.fstrim.enable = true; # Maintains SSD speed over time
  services.upower.enable = true; # Battery status management
  services.gvfs.enable = true;   # Handles USB auto-mounting, Trash, and network drives in XFCE

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
  security.sudo-rs.enable = true; # Memory-safe Rust implementation of sudo

  # Local File Sharing (AirDrop alternative)
  programs.localsend.enable = true;

  # Global Session Variables for X11 / GTK
  environment.sessionVariables = {
    GTK_CSD = "0";
    GDK_SCALE = "1";
  };
}