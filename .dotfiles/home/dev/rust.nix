{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "rust-dev-environment";

  buildInputs = with pkgs; [
    # Rust toolchain
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy

    # Build dependencies
    pkg-config
    openssl

    # Additional tools
    cargo-watch
    cargo-edit
    cargo-expand
  ];

  shellHook = ''
    echo "🦀 Rust development environment loaded!"
    echo "rustc version: $(rustc --version)"
    echo "cargo version: $(cargo --version)"
    echo ""
    echo "Available tools:"
    echo "  - cargo watch  (auto-rebuild on changes)"
    echo "  - cargo edit   (manage dependencies)"
    echo "  - cargo expand (expand macros)"
    echo ""
  '';

  # Set rust backtrace for better debugging
  RUST_BACKTRACE = "1";
}
