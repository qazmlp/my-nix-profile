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
          vivaldi
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
          ghostwriter
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
          kdenlive
          vlc
          pinta
          superTuxKart
          minetest
          aseprite
          medibangpaint
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
          gnome-paint
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
