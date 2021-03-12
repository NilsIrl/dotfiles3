self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "master";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "nightly";
      sha256 = "0qfblj170md2xxfwnnrv8xg0r0h28xli22g25rl3lm42km8ab5jq";
    };
    buildInputs = oldAttrs.buildInputs ++ [ super.tree-sitter ];
  });
}

