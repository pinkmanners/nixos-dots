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
    zlib
    libiconv

    # Enhanced cargo tools
    cargo-watch        # Auto-rebuild on changes
    cargo-edit         # Manage dependencies from CLI
    cargo-expand       # Expand macros
    cargo-nextest      # Better test runner
    cargo-deny         # Dependency security/license checks
    cargo-outdated     # Check for outdated dependencies
    cargo-audit        # Security vulnerability scanner
    cargo-flamegraph   # Profiling tool
    cargo-bloat        # Find what's taking up space in binary
    cargo-udeps        # Find unused dependencies
    bacon              # Background code checker

    # Additional useful tools
    ripgrep            # Fast grep alternative (rg)
    tokei              # Code statistics
  ];

  shellHook = ''
    echo "🦀 Rust development environment loaded!"
    echo ""
    echo "Toolchain versions:"
    echo "  rustc:  $(rustc --version)"
    echo "  cargo:  $(cargo --version)"
    echo ""
    echo "Available cargo extensions:"
    echo "  - cargo watch     (auto-rebuild on file changes)"
    echo "  - cargo edit      (add/remove/upgrade dependencies)"
    echo "  - cargo expand    (expand macros)"
    echo "  - cargo nextest   (improved test runner)"
    echo "  - cargo deny      (check dependencies for security/license)"
    echo "  - cargo outdated  (find outdated dependencies)"
    echo "  - cargo audit     (scan for security vulnerabilities)"
    echo "  - cargo flamegraph (generate flame graphs for profiling)"
    echo "  - cargo bloat     (analyze binary size)"
    echo "  - cargo udeps     (find unused dependencies)"
    echo "  - bacon           (background code checker)"
    echo ""
    echo "Additional tools:"
    echo "  - ripgrep (rg)    (fast code search)"
    echo "  - tokei           (code statistics)"
    echo ""

    # Check for cargo updates
    echo "Checking for cargo updates..."
    if command -v cargo &> /dev/null; then
      CARGO_VERSION=$(cargo --version | awk '{print $2}')
      echo "Current cargo version: $CARGO_VERSION"
      echo "Run 'rustup update' to update your Rust toolchain"
    fi
    echo ""
    echo "Ready to code! 🚀"
  '';

  # Environment variables for better Rust development
  RUST_BACKTRACE = "1";
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
