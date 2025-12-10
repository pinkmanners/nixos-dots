{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "ruby-dev-environment";

  buildInputs = with pkgs; [
    # Ruby interpreter (latest stable)
    ruby_3_4

    # Core Ruby tools
    bundler            # Dependency management
    rubocop            # Linter and code formatter

    # Development tools
    ruby-lsp           # Language server for editor integration
    solargraph         # Another Ruby language server option

    # Debugging and profiling
    ruby-debug-ide     # Debugger

    # Build dependencies
    pkg-config
    openssl
    zlib
    readline
    libyaml
    libffi
    gdbm
    ncurses

    # Additional useful tools
    ripgrep            # Fast grep for searching code
    tokei              # Code statistics
  ];

  shellHook = ''
    echo "💎 Ruby development environment loaded!"
    echo ""
    echo "Toolchain versions:"
    echo "  ruby:    $(ruby --version)"
    echo "  bundler: $(bundle --version)"
    echo ""
    echo "Available tools:"
    echo "  - bundler        (dependency management)"
    echo "  - rubocop        (linter and formatter)"
    echo "  - ruby-lsp       (language server)"
    echo "  - solargraph     (alternative language server)"
    echo "  - ruby-debug-ide (debugger)"
    echo ""
    echo "Additional tools:"
    echo "  - ripgrep (rg)   (fast code search)"
    echo "  - tokei          (code statistics)"
    echo ""

    # Check for Ruby/Bundler updates
    echo "Checking versions..."
    if command -v ruby &> /dev/null; then
      RUBY_VERSION=$(ruby --version | awk '{print $2}')
      echo "Current Ruby version: $RUBY_VERSION"
    fi
    if command -v bundle &> /dev/null; then
      BUNDLER_VERSION=$(bundle --version | awk '{print $3}')
      echo "Current Bundler version: $BUNDLER_VERSION"
    fi
    echo ""
    echo "Tip: Use 'bundle install' to install project dependencies"
    echo "Ready to code! 💎"
  '';

  # Ruby environment variables
  GEM_HOME = "$HOME/.gem";
  GEM_PATH = "$HOME/.gem";
}
