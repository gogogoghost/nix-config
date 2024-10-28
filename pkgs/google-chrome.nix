{ pkgs ? import <nixpkgs> {} }:
pkgs.google-chrome.overrideAttrs (old: {
  buildInputs = old.buildInputs or [] ++ [ pkgs.makeWrapper ];
  postInstall = old.postInstall or "" + ''
    wrapProgram $out/bin/google-chrome-stable \
      --set GTK_PATH "${pkgs.ibus}/lib/gtk-4.0/4.0.0" \
      --add-flags "--gtk-version=4"
  '';
})