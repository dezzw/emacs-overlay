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
      rev = "e43eff80d17cf34852dcd92ca5e6986d23a7040f";
      hash = "sha256-jokekIuuQLx5UtuPs4XAI+euispeFCwSQByVKVelrC4=";
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
