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
      rev = "69070d2e4563f8f58c7f57b0c8e093a08d7a5814";
      hash = "sha256-+Miraf8kI8rZg7SYdfNM+mb78k9xNDUKYg3VTFzUHMo=";
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
