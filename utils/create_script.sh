#! /usr/bin/env nix-shell
#! nix-shell -i bash -p pandoc
#!/usr/bin/env bash

# Assert arg
# if [ $# -eq 0 ]; then
#   echo "Usage: ${0}"
#   exit 1
# fi

input="slides.md"
parsed_file="script.md"
output="script.html"

# Parse text between <!-- and -->
sed -n -e '/<!--/{:a;N;/-->/!ba;s/<!--\(.*\)-->/\1/p}' -e 's/^# /\<hr\>\n&/p' "$input" > "$parsed_file"

pandoc -s -f markdown -t html "$parsed_file" -o "$output"

echo "Done converting. Outputted to $output"
