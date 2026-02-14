# Oracle Setup Guide

> Set up Claude Code + Oracle on a brand new PC — from zero to running.
>
> Copy-paste each step. Total time: ~30 minutes.

---

## What You'll Get

| Tool | What It Does |
|------|-------------|
| **WSL2 + Ubuntu** | Linux environment inside Windows |
| **Claude Code** | AI coding assistant (CLI) |
| **Oracle Skills** | 60+ productivity skills for Claude Code |
| **tmux** | Always-on sessions (close terminal, AI keeps running) |
| **git + gh** | Version control + GitHub CLI |
| **bun** | Fast JavaScript runtime & package manager |
| **node + npm** | JavaScript runtime |
| **python3** | Python runtime |
| **VS Code** | Code editor with WSL integration |

---

## Checklist

Use this to track your progress:

- [ ] Step 0: Windows prerequisites
- [ ] Step 1: Install WSL2 + Ubuntu
- [ ] Step 2: Update Ubuntu + essentials
- [ ] Step 3: Configure Git
- [ ] Step 4: Install GitHub CLI + login
- [ ] Step 5: Install Bun
- [ ] Step 6: Install Node.js
- [ ] Step 7: Install Python 3
- [ ] Step 8: Install Claude Code + login
- [ ] Step 9: Clone Oracle repo
- [ ] Step 10: Install Oracle Skills
- [ ] Step 11: Setup tmux (always-on)
- [ ] Step 12: VS Code integration
- [ ] Step 13: Verify everything
- [ ] Step 14: First run!

---

## Step 0: Windows Prerequisites

### 0.1 — Accounts (create if you don't have)

| Account | URL | What For |
|---------|-----|----------|
| **GitHub** | https://github.com/signup | Code hosting, Oracle repo |
| **Anthropic** | https://console.anthropic.com | Claude Code access |

### 0.2 — Install VS Code

Download and install from: https://code.visualstudio.com/

### 0.3 — Install Windows Terminal (recommended)

Better terminal than default. Get from Microsoft Store:

```
Microsoft Store → search "Windows Terminal" → Install
```

Or via PowerShell (Admin):

```powershell
winget install Microsoft.WindowsTerminal
```

### 0.4 — Enable Virtualization

WSL2 needs virtualization enabled in BIOS. Most modern PCs have this on by default.

If WSL2 install fails later, you may need to:
1. Restart PC → Enter BIOS (usually F2, F12, or DEL)
2. Find "Virtualization Technology" or "Intel VT-x" / "AMD-V"
3. Enable it → Save → Restart

---

## Step 1: Install WSL2 + Ubuntu

Open **PowerShell as Administrator** (right-click Start → Terminal (Admin)):

```powershell
wsl --install -d Ubuntu-24.04
```

**Restart your PC** when prompted.

After restart, Ubuntu terminal will open automatically. Create your Linux user:

```
Enter new UNIX username: yourusername
New password: ********
Retype new password: ********
```

> Remember this password! You'll need it for `sudo` commands.

### Verify WSL2

Open PowerShell and run:

```powershell
wsl --list --verbose
```

You should see:

```
  NAME            STATE           VERSION
* Ubuntu-24.04    Running         2
```

> **VERSION must be 2.** If it shows 1, fix it:
> ```powershell
> wsl --set-version Ubuntu-24.04 2
> ```

### Open Ubuntu

From now on, open Ubuntu by:
- Windows Terminal → click dropdown → Ubuntu, OR
- Type `wsl` in PowerShell

---

## Step 2: Update Ubuntu + Install Essentials

**Run in Ubuntu terminal:**

```bash
sudo apt update && sudo apt upgrade -y
```

```bash
sudo apt install -y build-essential curl wget unzip zip git \
  ca-certificates gnupg lsb-release software-properties-common \
  tmux htop jq zsh
```

> `sudo` will ask for the password you set in Step 1.

### Check your shell

```bash
echo $SHELL
```

- If it shows `/bin/bash` → you're on **bash** (default)
- If it shows `/bin/zsh` or `/usr/bin/zsh` → you're on **zsh**

> **Important:** The rest of this guide uses `source ~/.bashrc` for bash users. If you're on **zsh**, replace with `source ~/.zshrc` everywhere. See the [Bash vs Zsh](#bash-vs-zsh) section for details.

---

## Step 3: Configure Git

Replace with your own GitHub username and email:

```bash
git config --global user.name "YOUR_GITHUB_USERNAME"
```

```bash
git config --global user.email "YOUR_EMAIL@example.com"
```

```bash
git config --global init.defaultBranch master
```

---

## Step 4: Install GitHub CLI (gh)

### 4.1 — Install

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

### 4.2 — Login

```bash
gh auth login
```

Follow the prompts:
1. `GitHub.com`
2. `HTTPS`
3. `Login with a web browser`
4. Copy the one-time code shown in terminal
5. Press Enter → browser opens → paste code → authorize

### 4.3 — Verify

```bash
gh auth status
```

Should show: `Logged in to github.com`

---

## Step 5: Install Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

**Reload shell** (important!):

```bash
# bash users:
source ~/.bashrc

# zsh users:
source ~/.zshrc
```

Verify:

```bash
bun --version
```

---

## Step 6: Install Node.js

We use **fnm** (Fast Node Manager) — faster than nvm:

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

**Reload shell:**

```bash
# bash users:
source ~/.bashrc

# zsh users:
source ~/.zshrc
```

Install Node.js 22 (LTS):

```bash
fnm install 22
```

```bash
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

### 8.1 — Install

```bash
npm install -g @anthropic-ai/claude-code
```

### 8.2 — Verify

```bash
claude --version
```

### 8.3 — Login

```bash
claude
```

If browser opens automatically → login with your Anthropic account.

If browser doesn't open (common in WSL):

```bash
claude login --method device-code
```

Follow the instructions to enter the code at the URL shown.

After login, type `/exit` to quit Claude for now.

---

## Step 9: Clone Your Oracle Repo

### If you already have an Oracle repo:

Replace `YOUR_GITHUB_USERNAME` and `YOUR_ORACLE_REPO`:

```bash
mkdir -p ~/ghq/github.com/YOUR_GITHUB_USERNAME
```

```bash
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME
```

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO.git
```

```bash
cd YOUR_ORACLE_REPO
```

### If you don't have an Oracle repo yet:

```bash
mkdir -p ~/ghq/github.com/YOUR_GITHUB_USERNAME
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME
```

```bash
gh repo create my-oracle --private --clone
cd my-oracle
```

Then later in Step 14 you'll use `/awaken` to create your Oracle identity.

---

## Step 10: Install Oracle Skills

```bash
~/.bun/bin/bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y
```

Verify:

```bash
ls ~/.claude/skills/
```

You should see folders like: `recap`, `standup`, `trace`, `rrr`, `forward`, `feel`, etc.

---

## Step 11: Setup tmux (Always-On Sessions)

tmux lets your Oracle keep running even when you close the terminal.

### 11.1 — Create tmux config

```bash
cat >> ~/.tmux.conf << 'EOF'
# Mouse support
set -g mouse on

# Scrollback history
set -g history-limit 50000

# Colors
set -g default-terminal "screen-256color"

# Status bar
set -g status-style 'bg=#333333 fg=#ffffff'
set -g status-left ' Oracle '
set -g status-right ' %H:%M '
EOF
```

### 11.2 — tmux Cheat Sheet

| Action | How |
|--------|-----|
| **Start new session** | `tmux new-session -s oracle` |
| **Detach** (leave running) | `Ctrl+B` then `D` |
| **Reattach** (come back) | `tmux attach -t oracle` |
| **List sessions** | `tmux list-sessions` |
| **Kill session** | `tmux kill-session -t oracle` |
| **Scroll up** | `Ctrl+B` then `[` then arrow keys, `q` to exit |

### 11.3 — How it works

```
You start Claude in tmux:
  tmux new-session -s oracle → claude

You detach (Ctrl+B, D):
  Terminal closes, but Claude is STILL RUNNING

You come back later:
  tmux attach -t oracle → Claude is right where you left it!
```

---

## Step 12: VS Code Integration

From Ubuntu terminal, open your Oracle repo:

```bash
code ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
```

- VS Code will auto-install the **WSL extension**
- You're now editing files directly on the Linux filesystem
- Terminal in VS Code = Ubuntu terminal

---

## Step 13: Verify Everything

Run this health check script:

```bash
echo ""
echo "==============================="
echo "  Oracle WSL2 Health Check"
echo "==============================="
echo ""
echo "  Git:     $(git --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "  gh:      $(gh --version 2>/dev/null | head -1 || echo 'NOT INSTALLED')"
echo "  Bun:     $(bun --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "  Node:    $(node --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "  npm:     $(npm --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "  Python:  $(python3 --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "  Claude:  $(claude --version 2>&1 || echo 'NOT INSTALLED')"
echo "  tmux:    $(tmux -V 2>/dev/null || echo 'NOT INSTALLED')"
echo "  Skills:  $(ls ~/.claude/skills/ 2>/dev/null | wc -l) skills installed"
echo ""
echo "==============================="
echo ""
```

**Expected output:** All items show a version number, skills > 20.

If anything shows `NOT INSTALLED`, go back to that step.

---

## Step 14: First Run!

### Start your Oracle:

```bash
tmux new-session -s oracle
```

```bash
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
claude
```

### If you have an existing Oracle:

Type your startup command (e.g., `start Miipan`, `/recap`, etc.)

### If this is a new Oracle:

Type:

```
/awaken
```

The awakening ritual (~15 min) will guide you through:
1. Exploring the Oracle philosophy
2. Choosing your Oracle's name and personality
3. Creating identity files
4. First retrospective

---

## Quick Reference Card

### Daily Usage

```bash
# Open Ubuntu
wsl

# Start Oracle (or reattach)
tmux attach -t oracle || tmux new-session -s oracle

# Navigate to repo
cd ~/ghq/github.com/YOUR_USERNAME/YOUR_ORACLE

# Run Claude
claude
```

### Common Commands Inside Claude

| Command | What It Does |
|---------|-------------|
| `/recap` | Orient yourself, see what's going on |
| `/standup` | Morning check: tasks, schedule, progress |
| `/trace [topic]` | Search across history, repos, docs |
| `/rrr` | End-of-session retrospective |
| `/forward` | Create handoff for next session |
| `/feel [emotion]` | Log how you're feeling |
| `/fyi [info]` | Save info for future reference |

### Update Oracle Skills

Inside Claude Code:

```
/oracle-soul-sync-calibrate-update
```

---

## Troubleshooting

### WSL2 install fails — "Virtualization not enabled"

1. Restart PC → Enter BIOS (F2/F12/DEL during boot)
2. Find "Intel VT-x" or "AMD-V" or "Virtualization"
3. Enable it → Save → Restart
4. Try `wsl --install` again

### WSL2 is slow

Check it's version 2:

```powershell
wsl --list --verbose
```

If VERSION = 1:

```powershell
wsl --set-version Ubuntu-24.04 2
```

### Claude Code login doesn't open browser

Use device code method:

```bash
claude login --method device-code
```

### gh auth not working

Use a personal access token:

1. Go to https://github.com/settings/tokens
2. Generate new token (classic) with `repo` scope
3. Run:

```bash
gh auth login --with-token
```

Paste your token when prompted.

### "command not found" after installing bun/node/fnm

Reload your shell:

```bash
# bash users:
source ~/.bashrc

# zsh users:
source ~/.zshrc
```

Or close and reopen Ubuntu terminal.

### Accessing Windows files from WSL

```bash
ls /mnt/c/Users/YourWindowsUsername/
```

> **Important:** Files on `/mnt/c/` are slower. Always keep your Oracle repo on the Linux filesystem (`~/`) for best performance.

### tmux session gone after Windows restart

WSL sessions don't survive Windows restarts. After restarting Windows:

```bash
wsl
tmux new-session -s oracle
cd ~/ghq/github.com/YOUR_USERNAME/YOUR_ORACLE
claude
```

Then `/recap` to reorient.

### npm permission errors

If you get `EACCES` errors:

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
```

```bash
# bash users:
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# zsh users:
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

```bash
npm install -g @anthropic-ai/claude-code
```

---

## Do I need Homebrew?

**No.** Ubuntu has `apt` which is faster and more native. Everything in this guide installs directly without Homebrew.

| Tool | Mac uses | Ubuntu uses |
|------|----------|-------------|
| Package manager | `brew` | `apt` |
| Bun | `curl` installer | `curl` installer (same) |
| Node | `brew install node` or `fnm` | `fnm` (same) |
| Git | `brew install git` | `apt install git` |
| gh | `brew install gh` | `apt install gh` |

Same result, different installer. No extra layer needed.

---

## Why WSL2 instead of native Windows?

| Feature | Windows | WSL2 Ubuntu |
|---------|---------|-------------|
| Dev tool speed | Normal | 2-5x faster |
| Always-on (tmux) | Not possible | Yes |
| Linux compatibility | Limited | Full |
| VS Code support | Native | Via Remote-WSL |
| File system | NTFS (slower) | ext4 (fast) |
| Shell scripting | Limited | Full bash/zsh |
| Docker | Docker Desktop | Native Docker |

---

## Architecture

```
┌─────────────────────────────────────────┐
│              Windows 11                  │
│                                          │
│  ┌──────────┐  ┌──────────────────────┐ │
│  │ VS Code  │  │     WSL2 Ubuntu      │ │
│  │          ├──┤                      │ │
│  │ (editor) │  │  tmux ─── claude     │ │
│  │          │  │    │                 │ │
│  └──────────┘  │    └── Oracle repo   │ │
│                │        ├── CLAUDE.md │ │
│  ┌──────────┐  │        ├── skills/   │ │
│  │ Browser  │  │        └── memory/   │ │
│  │ (GitHub) │  │                      │ │
│  └──────────┘  └──────────────────────┘ │
└─────────────────────────────────────────┘
```

---

## Bash vs Zsh

Ubuntu defaults to **bash**, but some setups use **zsh** instead. Both work fine — just use the right config file.

| | Bash | Zsh |
|---|------|-----|
| Config file | `~/.bashrc` | `~/.zshrc` |
| Reload | `source ~/.bashrc` | `source ~/.zshrc` |
| Check which | `echo $SHELL` | `echo $SHELL` |
| Switch to bash | `chsh -s /bin/bash` | — |
| Switch to zsh | — | `chsh -s $(which zsh)` |

### If you installed tools with bash but switched to zsh

Some installers (bun, fnm) add config lines to `~/.bashrc`. If you're on zsh, those lines won't load. Fix it:

```bash
# Copy bun/fnm config from bashrc to zshrc
grep -E 'bun|fnm|BUN|FNM' ~/.bashrc >> ~/.zshrc
source ~/.zshrc
```

### Common zsh error: `shopt: command not found`

If you see this error:

```
/home/user/.bashrc:16: command not found: shopt
```

It means zsh is trying to source `.bashrc` which contains bash-only commands. **Don't source `.bashrc` from zsh.** Use `source ~/.zshrc` instead.

---

## Links

- [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- [Oracle Skills CLI](https://github.com/Soul-Brews-Studio/oracle-skills-cli)
- [Oracle Philosophy](https://github.com/Soul-Brews-Studio/oracle-v2)
- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [Windows Terminal](https://aka.ms/terminal)

---

*Made with Oracle philosophy: Nothing is deleted, everything is remembered.*
