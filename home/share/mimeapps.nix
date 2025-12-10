{ config, pkgs, lib, hostname, ... }:

# ----- default programs -----

let
  isModernSystem = builtins.elem hostname [ "L14" "T450" "BarkBox" ];

  codeEditor = if isModernSystem then "zed.desktop" else "org.kde.kate.desktop";
  webBrowser = if isModernSystem then "brave-browser.desktop" else "mullvad-browser.desktop";
in

{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        # web - conditional (brave or mullvad)
        #"text/html" = webBrowser;
        "x-scheme-handler/http" = webBrowser;
        "x-scheme-handler/https" = webBrowser;
        "x-scheme-handler/about" = webBrowser;
        "x-scheme-handler/unknown" = webBrowser;

        # code files - conditional (zed or kate)
        "text/x-python" = codeEditor;
        "text/x-rust" = codeEditor;
        "text/x-c" = codeEditor;
        "text/x-c++" = codeEditor;
        "text/x-java" = codeEditor;
        "application/javascript" = codeEditor;
        "application/json" = codeEditor;
        "application/xml" = codeEditor;
        "text/x-shellscript" = codeEditor;
        "text/x-nix" = codeEditor;
        "text/css" = codeEditor;
        "text/html" = codeEditor;

        # file management
        "inode/directory" = "thunar.desktop";
        "application/x-directory" = "thunar.desktop";
        "x-directory/normal" = "thunar.desktop";

        # plain text - kwrite
        "text/plain" = "org.kde.kwrite.desktop";

        # markdown - ghostwriter
        "text/markdown" = "ghostwriter.desktop";

        # pdfs - okular
        "application/pdf" = "org.kde.okular.desktop";

        # office - libreoffice
        "application/msword" = "libreoffice-writer.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
        "application/vnd.ms-excel" = "libreoffice-calc.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
        "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice-impress.desktop";
        "application/vnd.oasis.opendocument.text" = "libreoffice-writer.desktop";
        "application/vnd.oasis.opendocument.spreadsheet" = "libreoffice-calc.desktop";
        "application/vnd.oasis.opendocument.presentation" = "libreoffice-impress.desktop";

        # images - gwenview
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/png" = "org.kde.gwenview.desktop";
        "image/gif" = "org.kde.gwenview.desktop";
        "image/bmp" = "org.kde.gwenview.desktop";
        "image/webp" = "org.kde.gwenview.desktop";
        "image/svg+xml" = "org.kde.gwenview.desktop";
        "image/tiff" = "org.kde.gwenview.desktop";

        # raw photo formats - darktable
        "image/x-canon-cr2" = "darktable.desktop";
        "image/x-canon-crw" = "darktable.desktop";
        "image/x-nikon-nef" = "darktable.desktop";
        "image/x-sony-arw" = "darktable.desktop";
        "image/x-sony-sr2" = "darktable.desktop";
        "image/x-sony-srf" = "darktable.desktop";
        "image/x-adobe-dng" = "darktable.desktop";
        "image/x-panasonic-raw" = "darktable.desktop";
        "image/x-panasonic-rw2" = "darktable.desktop";
        "image/x-olympus-orf" = "darktable.desktop";
        "image/x-fuji-raf" = "darktable.desktop";
        "image/x-pentax-pef" = "darktable.desktop";

        # video - vlc
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";
        "video/x-msvideo" = "vlc.desktop";
        "video/quicktime" = "vlc.desktop";
        "video/webm" = "vlc.desktop";
        "video/mpeg" = "vlc.desktop";
        "video/x-flv" = "vlc.desktop";
        "video/x-ms-wmv" = "vlc.desktop";

        # audio - elisa
        "audio/mpeg" = "org.kde.elisa.desktop";
        "audio/mp4" = "org.kde.elisa.desktop";
        "audio/x-wav" = "org.kde.elisa.desktop";
        "audio/flac" = "org.kde.elisa.desktop";
        "audio/ogg" = "org.kde.elisa.desktop";
        "audio/x-vorbis+ogg" = "org.kde.elisa.desktop";
        "audio/aac" = "org.kde.elisa.desktop";
        "audio/x-opus+ogg" = "org.kde.elisa.desktop";
        "audio/x-ms-wma" = "org.kde.elisa.desktop";

        # archives - xarchiver
        "application/zip" = "xarchiver.desktop";
        "application/x-tar" = "xarchiver.desktop";
        "application/x-compressed-tar" = "xarchiver.desktop";
        "application/x-gzip" = "xarchiver.desktop";
        "application/x-bzip" = "xarchiver.desktop";
        "application/x-7z-compressed" = "xarchiver.desktop";
        "application/x-rar" = "xarchiver.desktop";
        "application/x-xz" = "xarchiver.desktop";
        "application/gzip" = "xarchiver.desktop";
        "application/x-bzip2" = "xarchiver.desktop";

        # torrents
        "application/x-bittorrent" = "transmission-qt.desktop";
        "x-scheme-handler/magnet" = "transmission-qt.desktop";

        # notes
        "x-scheme-handler/logseq" = "logseq.desktop";
      };

      associations.added = {
        "inode/directory" = [ "thunar.desktop" ];
        "application/x-directory" = [ "thunar.desktop" ];
      };
    };

    configFile."mimeapps.list".force = true;
  };
}
