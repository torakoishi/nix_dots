# ~/.dotfiles/configuration.nix

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./Profiles/zephyrus-ga503.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      tofu_kozo = import ./home.nix;
    };
  };

  # Bootloader.
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
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tofu_kozo = {
    isNormalUser = true;
    description = "tofu_kozo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

    ];
  };

  # Apply GTK themes to Wayland apps.
  programs.dconf.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Enable kde-connect and opens TCP and UDP ports 1714-1764.
  programs.kdeconnect.enable = true;

    # Allow unfree package repository.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    brave
    btop
    btrfs-progs
    cpufrequtils
    discord
    emote
    fastfetch
    ffmpeg_7
    glib
    glxinfo
    gparted
    hwdata
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    kdePackages.kio-admin
    kdePackages.qtstyleplugin-kvantum
    kdePackages.sddm-kcm
    konsave
    nixd
    unzip
    vscode
    wget
  ];

  # System fonts.
  fonts.packages = with pkgs; [
	  cascadia-code
    _3270font
    fira-code-nerdfont
    maple-mono-NF
    noto-fonts
 	];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  # use the example session manager.
  #media-session.enable = true;
  };

  # Enable CUPS to printing.
  services.printing = {
    enable = true;
  };

  # Enable touchpad support.
  services.libinput = {
    enable = true;
  };

  # Enable flatpak.
  services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Bluetooth support.
  hardware.bluetooth.enable = true; # enables support for bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers on default bluetooth controller on boot

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Don't edit this.
  system.stateVersion = "24.05"; # Did you read the comment?
}
