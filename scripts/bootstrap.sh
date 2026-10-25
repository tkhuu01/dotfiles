#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/projects"

# Don't replace a separately configured Git template directory.
current=$(git config --global --get init.templateDir || true)
case "$current" in
    ''|'~/.git-templates'|"$HOME/.git-templates")
        git config --global init.templateDir "$HOME/.git-templates"
        ;;
    *)
        printf 'Keeping your existing Git template directory: %s\n' "$current"
        printf 'The dotfiles commit-msg hook is available at %s\n' "$HOME/.git-templates/hooks/commit-msg"
        ;;
esac
