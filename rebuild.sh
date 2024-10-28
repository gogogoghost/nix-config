#!/bin/sh

home-manager switch --flake path:$(pwd)#jax-pc

update-desktop-database ~/.local/share/applications
