{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "ruby-dev-environment";

  buildInputs = with pkgs; [
    # Ruby interpreter
    ruby_3_3

    # Ruby tools
    bundler
    rubocop

    # Build dependencies
    pkg-config
    openssl
    zlib
    readline
  ];

  shellHook = ''
    echo "💎 Ruby development environment loaded!"
    echo "ruby version: $(ruby --version)"
    echo "bundler version: $(bundle --version)"
    echo ""
    echo "Available tools:"
    echo "  - bundler (dependency management)"
    echo "  - rubocop (linter)"
    echo ""
  '';
}
