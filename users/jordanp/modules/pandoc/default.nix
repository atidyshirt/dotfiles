{ pkgs, ... }:

let
  eisvogel = pkgs.fetchFromGitHub {
    owner = "Wandmalfarbe";
    repo = "pandoc-latex-template";
    rev = "v3.5.0";
    hash = "sha256-WkQ3s3tqjpcEcst8myW4HzdWPFx6nBt5ki0zPMHE3/w=";
  };
in {
  home.packages = [ pkgs.pandoc pkgs.texliveFull ];

  home.sessionVariables.EISVOGEL_TEMPLATE =
    "${eisvogel}/eisvogel.tex";
}
