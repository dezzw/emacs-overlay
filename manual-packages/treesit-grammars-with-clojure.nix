{
  fetchFromGitHub,
  pkgs,
  treesit-grammars,
}:

let
  clojure-grammar = pkgs.tree-sitter.buildGrammar {
    language = "clojure";
    version = "unstable-20250526";
    src = fetchFromGitHub {
      owner = "sogaiu";
      repo = "tree-sitter-clojure";
      rev = "56a4c9de7940d18bad086cce0815544e0ac2b7f6";
      hash = "sha256-dGIGPuhrpsYFIXhWhwiMSJKx2Gtk1WLfyuQ0DefIeXI=";
    };
  };
in

treesit-grammars.with-grammars (
  grammars:
  let
    grammarList = builtins.attrValues grammars;
    filtered = builtins.filter (grammar: grammar.language or "" != "clojure") grammarList;
  in
  filtered ++ [ clojure-grammar ]
)
