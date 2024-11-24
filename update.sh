#!/bin/sh

set -e 

nix flake update --flake path:$(pwd)