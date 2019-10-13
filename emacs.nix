with import <nixpkgs> {};

stdenv.lib.overrideDerivation (pkgs.emacs.override {
  srcRepo = true;
  withXwidgets = true;
}) (attrs: rec {
  name = "emacs-${version}${versionModifier}";
  imagemagick = pkgs.imagemagickBig;
  version = "27.0";
  versionModifier = ".50";

  doCheck = false;

  patches = null;

  configureflags = attrs.configureFlags ++ [
    "--with-harfbuzz"
    "--with-json"
  ];

  buildInputs = attrs.buildInputs ++ [
    harfbuzz
    jansson
  ];

  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "0f801d4a5e37e69c4e527830f13f255a6f01360b";
    sha256 = "1c9c3kanj6ahv371kakz3qilv5pqm2pl0q4bg0d9qbz8amndy8mi";
    # my old ones in case those with harfbuzz build don't work
    # rev = "7aaf500701be3b51c686b7d86c9b505ef5fa9b8f";
    # sha256 = "03l7ffibsxbiyn0xdmc6888ichb2mkrdrl5migrzp478gxy6614w";
  };
})
