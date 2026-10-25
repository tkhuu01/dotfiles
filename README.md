# Dotfiles

## Setup

```sh
./install --dry-run
./install
```

`install` installs mise if needed, trusts the repository, and delegates to
`mise bootstrap`, then appends the inline shell setup to `~/.bashrc`.
`--dry-run` and `--help` skip that append. Running `mise bootstrap` directly
does not run the inline shell setup; use `./install` for the complete setup.
A dry run requires mise to be installed already. This setup
requires mise 2026.10.18 or newer.
With mise already installed:

```sh
mise trust
mise bootstrap --dry-run
mise bootstrap
```

Run bootstrap from `~/dotfiles`, or use `mise -C ~/dotfiles bootstrap`.
The declared source paths expect the checkout at `~/dotfiles`.
Open a new shell after applying the setup.

## Layout

- `mise.toml`: tool versions, settings, host packages, TPM, dotfile links, shell
  activation, and the final setup task. The global config links to this file.
- `install`: inline Bash aliases, functions, and prompt setup after bootstrap.
- `git/commit-msg`: the executable Git template hook that prefixes branch tickets.
- `scripts/bootstrap.sh`: repeatable projects-directory and Git-template setup.

## Maintenance

```sh
mise bootstrap --dry-run
mise bootstrap --only dotfiles,mise-shell-activate
mise bootstrap status
mise bootstrap --update  # refresh package metadata and declared repositories
```

Ordinary bootstrap installs missing packages/tools; it does not mean "upgrade
every pinned tool". Update versions in `mise.toml` deliberately. The final
bootstrap task can run repeatedly without appending duplicate shell content.
