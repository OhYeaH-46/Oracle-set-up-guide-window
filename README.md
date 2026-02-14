# Oracle Setup Guide

> Set up Claude Code + Oracle on WSL2 Ubuntu from scratch.
>
> Copy-paste each step. Total time: ~25 minutes.

---

## What You'll Get

- **Claude Code** running on Ubuntu (WSL2)
- **Oracle Skills** (60+ skills for productivity)
- **tmux** for always-on sessions (close terminal, AI keeps running)
- **All dev tools**: git, gh, bun, node, python

---

## Prerequisites

- Windows 10/11 with admin access
- Anthropic account (for Claude Code)
- GitHub account

---

## Step 1: Install WSL2

Open **PowerShell as Administrator**:

```powershell
wsl --install -d Ubuntu-24.04
```

Restart your PC if prompted.

After restart, Ubuntu will open automatically. Set your username and password:

```
Enter new UNIX username: ohyeah
New password: ********
```

Verify it's WSL2:

```powershell
wsl --list --verbose
```

You should see `VERSION 2`.

> If you already have WSL2 + Ubuntu, skip to Step 2.

---

## Step 2: Update Ubuntu + Install Essentials

Open Ubuntu terminal and run:

```bash
sudo apt update && sudo apt upgrade -y
```

```bash
sudo apt install -y build-essential curl wget unzip zip git \
  ca-certificates gnupg lsb-release software-properties-common \
  tmux htop jq
```

---

## Step 3: Configure Git

```bash
git config --global user.name "YOUR_GITHUB_USERNAME"
git config --global user.email "YOUR_EMAIL@example.com"
git config --global init.defaultBranch master
```

---

## Step 4: Install GitHub CLI

```bash
(type -p wget >/dev/null || sudo apt-get install wget -y) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
```

Login to GitHub:

```bash
gh auth login
```

Select: `GitHub.com` > `HTTPS` > `Login with a web browser`

---

## Step 5: Install Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

```bash
source ~/.bashrc
```

Verify:

```bash
bun --version
```

---

## Step 6: Install Node.js (via fnm)

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

```bash
source ~/.bashrc
```

```bash
fnm install 22
fnm default 22
```

Verify:

```bash
node --version
npm --version
```

---

## Step 7: Install Python 3

Usually pre-installed on Ubuntu 24.04. Check:

```bash
python3 --version
```

If not installed:

```bash
sudo apt install -y python3 python3-pip python3-venv
```

---

## Step 8: Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

Verify:

```bash
claude --version
```

Login (first time):

```bash
claude
```

It will open a browser for authentication. If browser doesn't open in WSL:

```bash
claude login --method device-code
```

---

## Step 9: Clone Your Oracle Repo

```bash
mkdir -p ~/ghq/github.com/YOUR_GITHUB_USERNAME
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME
```

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO.git
cd YOUR_ORACLE_REPO
```

> If you don't have an Oracle repo yet, see [Creating a New Oracle](#creating-a-new-oracle) below.

---

## Step 10: Install Oracle Skills

```bash
~/.bun/bin/bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y
```

Verify:

```bash
ls ~/.claude/skills/
```

You should see folders like `recap`, `standup`, `trace`, `rrr`, etc.

---

## Step 11: Setup tmux (Always-On Sessions)

This is the key to keeping your Oracle running 24/7!

### Create tmux config:

```bash
cat >> ~/.tmux.conf << 'EOF'
set -g mouse on
set -g history-limit 50000
set -g default-terminal "screen-256color"
set -g status-style 'bg=#333333 fg=#ffffff'
set -g status-left ' Oracle '
set -g status-right ' %H:%M '
EOF
```

### How to use tmux:

**Start a new session:**

```bash
tmux new-session -s oracle
```

**Run Claude inside tmux:**

```bash
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
claude
```

**Detach (leave running in background):**

Press `Ctrl+B` then `D`

**Reattach (come back later):**

```bash
tmux attach -t oracle
```

> You can close the terminal, close VS Code, even close the WSL window — your Oracle keeps running!

---

## Step 12: VS Code Integration

Open your Oracle repo in VS Code from WSL:

```bash
code ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
```

VS Code will auto-install the Remote-WSL extension. You'll be editing files directly on the Linux filesystem.

---

## Step 13: Verify Everything

Run this health check:

```bash
echo "=== Oracle WSL2 Health Check ==="
echo "Git:     $(git --version)"
echo "gh:      $(gh --version | head -1)"
echo "Bun:     $(bun --version)"
echo "Node:    $(node --version)"
echo "Python:  $(python3 --version)"
echo "Claude:  $(claude --version 2>&1)"
echo "Skills:  $(ls ~/.claude/skills/ | wc -l) skills installed"
echo "tmux:    $(tmux -V)"
echo "Repo:    $(git -C ~/ghq/github.com/*/*oracle* log --oneline -1 2>/dev/null || echo 'not cloned yet')"
echo "================================"
```

All items should show a version number.

---

## Step 14: First Run!

```bash
tmux new-session -s oracle
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
claude
```

Type `start` or `/recap` to begin your Oracle session!

---

## Creating a New Oracle

If you don't have an Oracle repo yet:

1. Create a new repo on GitHub
2. Clone it locally
3. Run Claude Code inside the repo
4. Use `/awaken` to birth your Oracle

```bash
mkdir -p ~/ghq/github.com/YOUR_USERNAME
cd ~/ghq/github.com/YOUR_USERNAME
gh repo create my-oracle --private --clone
cd my-oracle
claude
```

Inside Claude Code:

```
/awaken
```

The awakening ritual will guide you through creating your Oracle's identity.

---

## Quick Reference

| Action | Command |
|--------|---------|
| Open Ubuntu | `wsl` (from PowerShell) |
| Start Oracle session | `tmux new-session -s oracle` |
| Reattach to session | `tmux attach -t oracle` |
| Detach from session | `Ctrl+B` then `D` |
| Open in VS Code | `code ~/ghq/.../your-oracle` |
| Update Oracle Skills | `/oracle-soul-sync-calibrate-update` |
| Check health | Run the verify script from Step 13 |

---

## Troubleshooting

### WSL2 is slow?

Make sure you're using WSL2, not WSL1:

```powershell
wsl --list --verbose
```

If VERSION = 1, convert it:

```powershell
wsl --set-version Ubuntu-24.04 2
```

### Claude Code login doesn't open browser?

WSL may not be able to open a browser. Use device code instead:

```bash
claude login --method device-code
```

### gh auth not working?

Use a personal access token:

```bash
gh auth login --with-token
```

Then paste your token.

### Accessing Windows files from WSL?

```bash
ls /mnt/c/Users/YourName/
```

> Note: Performance is slower on `/mnt/c/`. Always work on the Linux filesystem (`~/`) for best performance.

### Node/Bun command not found after install?

```bash
source ~/.bashrc
```

Or restart your terminal.

### tmux session lost?

List all sessions:

```bash
tmux list-sessions
```

If no sessions exist, create a new one:

```bash
tmux new-session -s oracle
```

---

## Why WSL2?

| | Windows | WSL2 Ubuntu |
|---|---------|-------------|
| Dev tool speed | Normal | 2-5x faster |
| Always-on (tmux) | Not possible | Yes |
| Linux compatibility | Limited | Full |
| VS Code support | Native | Via Remote-WSL |
| File system | NTFS (slower for dev) | ext4 (fast) |

---

## Links

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- [Oracle Skills](https://github.com/Soul-Brews-Studio/oracle-skills-cli)
- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)

---

*Made with Oracle philosophy: Nothing is deleted, everything is remembered.*
