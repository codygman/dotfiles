{ config, pkgs, home, ... }:

with import <nixpkgs> {};
with lib;

let
  emacsHEAD = import ./emacs.nix;
in
{

  services = (if stdenv.isDarwin then {} else {

    emacs = {
      # emacs service not available on darwin?
      enable = true;
    };

    syncthing = {
      enable = true;
    };

    redshift = {
      enable = (if stdenv.isDarwin then false else true);
      # provider = "geoclue2";
      # 33.1212019" N, 97.1827227" W
      latitude = "33.121";
      longitude = "97.1827";
      temperature = {
        day = 6500;
        night = 3800;
      };
      # brightness = {
      #   day = "0.9";
      #   night = "0.65";
      # };
    };

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };


  });


  programs = {
  # Let Home Manager install and manage itself.
    home-manager.enable = true;
    emacs = {
      enable = true;
      package = emacsHEAD;
    };

    ssh = {
      enable = true;
      controlPath = "~/.ssh/master-%C";
    };


    git = {
      enable = true;
      userName = "codygman";
      userEmail = "codygman.consulting@gmail.com";
    };
    htop.enable = true;
    firefox.enable = true; # todo install with home-manager
    vim.enable = true;
    jq.enable = true;
    # notmuch = {
    #   enable = true;
    #   hooks = {
    #     preNew = "mbsync --all";
    #   };
    # };
  };

  home.packages = with pkgs; [
    # redshift-plasma-applet # this doesn't really work
    ripgrep

    ghc
    haskellPackages.lens
    haskellPackages.pandoc
    haskellPackages.ghcid
    haskellPackages.hlint
    stack
    cabal2nix
    haskellPackages.brittany
    haskellPackages.hpack
    haskellPackages.cabal-install
  ] ++ (if stdenv.isDarwin then [] else [steam]);

  systemd.user.startServices = true;

  xsession = {
    enable = (if stdenv.isDarwin then false else true);
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hpkgs: with hpkgs; [
        xmonad-contrib
      ];
      config = ~/dotfiles/xmonad/xmonad.hs;
    };
  };

  home.keyboard = {
    layout = "us";
    options = [
      "ctrl:nocaps"
    ];
  };

  home.sessionVariables = {
    EDITOR = "emacsclient --create-frame --alternate-editor emacs";
  };


  accounts.email.accounts = {
    "codygman.consulting@gmail.com" = {
      primary = true;
      address = "codygman.consulting@gmail.com";
      userName = "codygman.consulting@gmail.com";
      realName = "Cody Goodman";
    };
  };

  # accounts.email.accounts = {
  #     "codygman.consulting@gmail.com" = {
  #        mbsync.enable = false;
  #        mbsync.create = "maildir";
  #        notmuch.enable = true;
  #        msmtp.enable = true;
  #        primary = true;
  #        address = "codygman.consulting@gmail.com";
  #        userName = "codygman.consulting@gmail.com";
  #        realName = "Cody Goodman";
  #        passwordCommand = "cat /home/cody/gmailpasswd";
  # 
  #        imap = {
  #          host = "gmail.com";
  #          port = 993;
  #          tls.enable = true;
  #        };
  # 
  #        smtp = {
  #          host = "gmail.com";
  #          port = 587;
  #          # useStartTls = true;
  #        };
  #      };
  #   };

}
