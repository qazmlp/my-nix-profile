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
          # Rust development
          rustup
          cargo-edit  # adds cargo add/rm/upgrade commands
          cargo-watch # for watch-and-rebuild workflow
          cargo-audit # for security audits
          cargo-expand # for macro expansion
          cargo-flamegraph # for performance profiling
          cargo-outdated # for dependency checking
          pkg-config
          openssl
          # C++ development
          clang
          clang-tools  # includes clang-format, clang-tidy, etc.
          cmake
          ninja
          gdb
          lldb
          bear  # for generating compilation database
          ccache  # for faster rebuilds
          boost
          fmt

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
          # vivaldi is not in nixpkgs; install via Flatpak:
          # This will auto-install Vivaldi if flatpak is available and not already installed.
          # To enable, run: nix run .#installVivaldiFlatpak

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

        # Add a custom flake output to automate Vivaldi Flatpak installation
        apps.installVivaldiFlatpak = {
          type = "app";
          program =
            let
              script = ''
                #!/usr/bin/env bash
                if ! command -v flatpak >/dev/null; then
                  echo "Flatpak is not installed. Please install flatpak first." >&2
                  exit 1
                fi
                # Add Flathub if not present
                if ! flatpak remote-list | grep -q flathub; then
                  echo "Adding Flathub remote..."
                  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
                fi
                if flatpak list | grep -q com.vivaldi.Vivaldi; then
                  echo "Vivaldi is already installed via Flatpak."
                else
                  echo "Installing Vivaldi via Flatpak..."
                  flatpak install -y flathub com.vivaldi.Vivaldi
                fi
              '';
            in
              "${pkgs.writeShellScriptBin "install-vivaldi-flatpak" script}/bin/install-vivaldi-flatpak";
        };
      }
    );
}
