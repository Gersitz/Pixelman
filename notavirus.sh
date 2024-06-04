#!/bin/sh
echo -ne '\033c\033]0;Pixelman\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/notavirus.x86_64" "$@"
