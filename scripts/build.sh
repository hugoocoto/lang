#!/bin/bash
set -e

# funny animation tho
find . -type f -name "*.typ" ! -path "*/\.*" | while read -r typ_file; do
    echo -en "  typst compile $typ_file \r"
    typst compile "$typ_file"
done

echo -e "Done\033[J"
