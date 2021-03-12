# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./secrets.nix
    ];

  nix.nixPath = [
    # Custom configuration.nix location
    "nixos-config=/home/nils/.config/nixos/configuration.nix"

    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_latest;
    #extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      timeout = null;
    };
  };

  networking = {
    hostName = "nixos";
    firewall = {
      enable = true;
      extraCommands = ''
        iptables -F OUTPUT
        iptables -A OUTPUT --match owner --uid-owner transmission --out-interface tun0 --jump RETURN
        iptables -A OUTPUT --match owner --uid-owner transmission --out-interface lo --jump RETURN
        iptables -A OUTPUT --match owner --uid-owner transmission --jump REJECT
      '';
    };
    nameservers = [ "208.67.222.222" "208.67.220.220" ];
    wireless.enable = true;
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "tun0";
    };
  };

  # Select internationalisation properties.
  console.keyMap = "uk";

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.alacritty
    pkgs.anki

    pkgs.neomutt
    pkgs.isync

    pkgs.newsboat

    (pkgs.pass.withExtensions( exts: [ exts.pass-otp ] ))
    (pkgs.firefox-wayland.override { extraNativeMessagingHosts = [ pkgs.passff-host ]; })

    pkgs.xdg-user-dirs
    pkgs.xdg_utils

    pkgs.unzip

    pkgs.file
    pkgs.git
    pkgs.rustup
    pkgs.python3

    pkgs.tdesktop

    pkgs.manpages

    pkgs.btrfs-progs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    bash.promptInit = ''
      PROMPT_COLOR="1;31m"
      let $UID && PROMPT_COLOR="1;32m"
      PS1="\[\033[$PROMPT_COLOR\]\w\\$\[\033[0m\] "
      unset PROMPT_COLOR
    '';
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mosh.enable = true;
    sway = {
      enable = true;
      extraPackages = [
        pkgs.bemenu
        pkgs.mako
        pkgs.swayidle
        pkgs.swaylock
        pkgs.wl-clipboard

        pkgs.grim
        pkgs.slurp

        pkgs.wob

        pkgs.jq
      ];
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };
    thefuck = {
#      alias = "fuck --enable-experimental-instant-mode";
      enable = true;
    };
    tmux.enable = true;
  };

  # List services that you want to enable:
  services = {
    mingetty.autologinUser = "nils";
    printing.enable = true;
    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
    };
    mpd = {
      # enable = true;
      # startWhenNeeded = true;
      musicDirectory = "/home/nils/Music";
      user = "nils";
      group = "users";
      extraConfig = ''
        audio_output {
          type "alsa"
          name "My ALSA output"
          device "front:CARD=PCH,DEV=0"
          mixer_control "PCM"
        }
      '';
    };
    transmission.enable = true;
  };

  fonts.fonts = [
    pkgs.fira-code
  ];

  documentation = {
    dev.enable = true;
  #  nixos.enable = true;
};

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    sane = {
      enable = true;
      extraBackends = pkgs.lib.singleton (pkgs.writeTextFile {
        name = "xerox_mfp.conf";
        text = ''
          tcp 192.168.1.210
        '';
        destination = "/etc/sane.d/xerox_mfp.conf";
      });
    };   
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nils = {
    extraGroups = [ "wheel" "scanner" "transmission" "docker" ];
    isNormalUser = true;
  };

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system = {
    stateVersion = "20.03"; # Did you read the comment?
    copySystemConfiguration = true;
  };
}
