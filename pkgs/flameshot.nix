{ pkgs ? import <nixpkgs> {} }:
pkgs.writeShellScriptBin "flameshot-wrapper" ''
    #!/usr/bin/env bash
    ${pkgs.flameshot}/bin/flameshot gui
''