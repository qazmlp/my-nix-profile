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
          # Core utilities
          git
          curl
          htop

          # Development
          vscode

          # Security & sync
          keepassxc
          syncthing
          syncthingtray

          # Communication
          element-desktop
          telegram-desktop
          discord
          teamspeak_client
          thunderbird

          # Browsers
          rPackages.vivaldi

          # Productivity & creative
          obsidian
          kdePackages.ghostwriter
          xournalpp
          focuswriter
          krita
          gimp
          inkscape
          blender
          audacity
          kdePackages.kdenlive
          vlc
          pinta

          # Gaming
          steam
          lutris
          heroic
          prismlauncher
          mangohud
          gamemode
          bottles
          obs-studio
          vkbasalt
          superTuxKart
          minetest
          itch

          # Fun/whimsical
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
          rig
          figlet

          # Art & education
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

          # Special interest
          intiface-central

          # Utilities
          flameshot
          signal-desktop
        ];
      in {
        packages.myPackages = pkgs.buildEnv {
          name = "my-profile";
          paths = myPackages;
        };
        # Provide a default package for convenience
        packages.default = self.packages.${system}.myPackages;
      }
    );
}
