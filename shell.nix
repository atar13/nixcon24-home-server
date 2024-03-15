# You can use this file to set up all the dependencies
# for this project. Run `nix-shell`.
{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.marp-cli
  ];
  shellHook = ''
    alias make='marp --html slides.md'
    echo "Use \`marp --html slides.md\` (aliased to \`make\`) to build \`slides.html\`"
  '';
}

