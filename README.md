# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io). Secrets are stored in [Bitwarden](https://bitwarden.com) and fetched at apply time.

## Install on a new machine

### Prerequisites

- macOS or Arch Linux
- Bitwarden account with the vault populated (see [Secrets](#secrets))

### Bootstrap

```sh
sh <(curl -fsSL https://raw.githubusercontent.com/Subbeh/dots/main/install.sh)
```

The script will:

1. Install `age`, `bitwarden-cli`, and `chezmoi` (via Homebrew on macOS, pacman on Arch)
2. Log in to Bitwarden and prompt for your master password if `BW_SESSION` is not already set
3. Run `chezmoi init --apply` which:
   - Clones this repo to `~/workspace/chezmoi` (macOS) or `/data/workspace/chezmoi` (Linux)
   - Fetches all secrets from Bitwarden and caches them to `.chezmoidata/secrets.json`
   - Writes the age encryption key to `~/.config/chezmoi/key.txt`
   - Imports GPG and SSH keys
   - Applies all dotfiles

### Skip Bitwarden login

If you already have a valid `BW_SESSION` exported in your shell, the script will skip the login step:

```sh
export BW_SESSION="<your session token>"
sh <(curl -fsSL https://raw.githubusercontent.com/Subbeh/dots/main/install.sh)
```

### Custom source directory

Override the default clone location with `SOURCE_DIR`:

```sh
SOURCE_DIR=/custom/path sh <(curl -fsSL https://raw.githubusercontent.com/Subbeh/dots/main/install.sh)
```

---

## Day-to-day usage

| Task | Command |
|------|---------|
| Apply pending changes | `chezmoi apply` |
| See what would change | `chezmoi diff` |
| Edit a managed file | `chezmoi edit <file>` |
| Pull latest and apply | `chezmoi update` |
| Add a new file | `chezmoi add <file>` |
| See managed files | `chezmoi managed` |

---

## Secrets

Secrets are fetched from Bitwarden by `run_onchange_before_01-fetch-secrets.sh.tmpl` and cached to `.chezmoidata/secrets.json` (gitignored). The fetch script runs automatically whenever its contents change.

The following Bitwarden items are required:

| Bitwarden item | Type | Detail |
|----------------|------|--------|
| `chezmoi` | Custom field | `age-key`, `age-key-pub` |
| `<ssh-key-name>` | SSH Key | private + public (one item per key in `sshKeys`) |
| `gpg-keys` | Attachment | `<email>.priv.asc`, `<email>.pub.asc`, `<email>.sub_priv.asc` |
| `github.com` | Custom field | `gh-cli-token` |
| `atlassian.com-jamf` | Custom field | `api-key` |

---

## Testing

A Docker-based test environment is available for testing the bootstrap on Arch Linux:

```sh
BW_SESSION="$BW_SESSION" ./test/test.sh
```

This builds an `archlinux` container, mounts this repo and your local Bitwarden data, and runs `install.sh` inside it.
