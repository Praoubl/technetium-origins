#!/bin/sh
NEW_VERSION="$1"
set -o errexit
[ -n "$NEW_VERSION" ]
git stash
sed -i '/^version=/s/"[0-9.]*"$/"'"$NEW_VERSION"'"/' META-INF/mods.toml
sed -i '/"version":/s/"[0-9.]*",$/"'"$NEW_VERSION"'",/' pack.mcmeta fabric.mod.json
git add META-INF/mods.toml pack.mcmeta fabric.mod.json
git commit -m "v$NEW_VERSION"
git tag "v$NEW_VERSION"
git stash list --max-age=$(date -d '5 seconds ago' +%s) | grep -q '' && git stash pop
