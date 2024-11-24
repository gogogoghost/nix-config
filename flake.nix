{
  description = "jax home config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      flameshot-wrapper = import ./pkgs/flameshot.nix { pkgs = pkgs; };
      google-chrome-wrapper = import ./pkgs/google-chrome.nix {pkgs=pkgs;};
    in {
      homeConfigurations.jax-pc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [{
          home = {
            stateVersion = "24.11";
            username = "jax";
            homeDirectory = "/home/jax";
            packages = with pkgs; [
              google-chrome-wrapper
              vscode
              android-studio
              spotify
              flameshot-wrapper
              vlc
              postman
              dbeaver-bin
              # nix file formatter
              nixfmt-classic

              wqy_microhei
              jdk
              openssh
            ];
            file={
              ".config/ibus/rime/default.custom.yaml".source=./ibus/default.custom.yaml;
              ".config/ibus/rime/ibus_rime.custom.yaml".source=./ibus/ibus_rime.custom.yaml;
            };
          };
          programs = {
            git = {
              enable = true;
              userName = "Jax Yang";
              userEmail = "jaxyang39@gmail.com";
            };
          };
          dconf.settings = {
            "org/gnome/desktop/background" = {
              picture-uri = "file:///usr/share/backgrounds/gnome/blobs-l.svg";
              picture-uri-dark =
                "file:///usr/share/backgrounds/gnome/blobs-d.svg";
              primary-color = "#241f31";
            };
            "org/gtk/gtk4/settings/file-chooser" = {
              sort-directories-first = true;
            };
            "org/gnome/desktop/session" = { idle-delay = 900; };
            "org/gnome/settings-daemon/plugins/power" = {
              sleep-inactive-ac-timeout = 0;
              sleep-inactive-ac-type = "nothing";
            };
            "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
            "org/gnome/desktop/wm/preferences" = {
              button-layout = ":minimize,maximize,close";
            };
            "org/gnome/settings-daemon/plugins/media-keys" = {
              custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kgx/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/"
              ];
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kgx" =
              {
                name = "kgx";
                command = "kgx";
                binding = "<Super>t";
              };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus" =
              {
                name = "nautilus";
                command = "nautilus";
                binding = "<Super>e";
              };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot" =
              {
                name = "flameshot";
                command = "flameshot-wrapper";
                binding = "<Control><Alt>A";
              };
          };
        }];
      };
    };
}
