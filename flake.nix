{
  description = "A simple Nix flake to install packages in your profile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        # List your desired packages here
        myPackages = with pkgs; [
          git
          curl
          htop
          vscode
          rPackages.vivaldi
          keepassxc
          syncthing
          syncthingtray
          element-desktop
          flameshot
          signal-desktop
          steam
          lutris
          heroic
          prismlauncher
          mangohud
          gamemode
          bottles
          discord
          teamspeak_client
          obs-studio
          vkbasalt
          obsidian
          kdePackages.ghostwriter
          xournalpp
          focuswriter
          krita
          gimp
          inkscape
          blender
          telegram-desktop
          firefox
          thunderbird
          audacity
          intiface-central
          itch
          sl
          cowsay
          fortune
          nyancat
          toilet
          bb
          cmatrix
          lolcat
          asciiquarium
          ponysay
          oneko
          xeyes
          rig
          figlet
          kdePackages.kdenlive
          vlc
          pinta
          superTuxKart
          minetest
          aseprite
          tuxpaint
          drawpile
          mypaint
          shotcut
          handbrake
          gthumb
          feh
          qbittorrent
          filezilla
          mumble
          element-web
          cheese
          simplescreenrecorder
        ];
      in {
        packages.myPackages = pkgs.buildEnv {
          name = "my-profile";
          paths = myPackages;
        };
      }
    );
}
