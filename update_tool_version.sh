#!/bin/bash
# Updates either the Elixir or erlang version everywhere in the project
# Credits: https://gist.github.com/PJUllrich/7b3f7a9d5737cdba4d90098526a1420e

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 old_version new_version. Example: $0 1.15.7 1.16.1"
  exit 1
fi

# Trims leading and trailing whitespaces
old_version=$(echo "$1" | awk '{$1=$1;print}')
new_version=$(echo "$2" | awk '{$1=$1;print}')
trimmed_old_version="${old_version%%-otp*}"
trimmed_new_version="${new_version%%-otp*}"

file_tool_versions=".tool-versions"
file_dockerfile="Dockerfile"
file_mix="mix.exs"

for file in $file_tool_versions $file_github_action; do
  if [ -f "$file" ]; then
    sed -i "" "s/$old_version/$new_version/g" $file
  else
    echo "Warning: The file at '$file' does not exist. Skipping."
  fi
done

for file in $file_dockerfile $file_mix; do
  if [ -f "$file" ]; then
    sed -i "" "s/$trimmed_old_version/$trimmed_new_version/g" $file
  else
    echo "Warning: The file at '$file' does not exist. Skipping."
  fi
done
