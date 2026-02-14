# Oracle Setup Guide

> Set up Claude Code + Oracle on a brand new PC — from zero to running.
>
> Copy-paste each step. Total time: ~30 minutes.
>
> This guide uses **zsh** (with Oh My Zsh) as the default shell.

---

## What You'll Get

| Tool | What It Does |
|------|-------------|
| **WSL2 + Ubuntu** | Linux environment inside Windows |
| **zsh + Oh My Zsh** | Modern shell with autocomplete and themes |
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

- [ ] Step 0: Windows prerequisites
- [ ] Step 1: Install WSL2 + Ubuntu
- [ ] Step 2: Update Ubuntu + essentials
- [ ] Step 3: Install zsh + Oh My Zsh
- [ ] Step 4: Configure Git
- [ ] Step 5: Install GitHub CLI + login
- [ ] Step 6: Install Bun
- [ ] Step 7: Install Node.js
- [ ] Step 8: Install Python 3
- [ ] Step 9: Install Claude Code + login
- [ ] Step 10: Clone Oracle repo
- [ ] Step 11: Install Oracle Skills
- [ ] Step 12: Setup tmux (always-on)
- [ ] Step 13: VS Code integration
- [ ] Step 14: Verify everything
- [ ] Step 15: First run!

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

**All commands from here are run in Ubuntu terminal.**

```bash
sudo apt update && sudo apt upgrade -y
```

```bash
sudo apt install -y build-essential curl wget unzip zip git \
  ca-certificates gnupg lsb-release software-properties-common \
  tmux htop jq zsh
```

> `sudo` will ask for the password you set in Step 1.

---

## Step 3: Install zsh + Oh My Zsh

### 3.1 — Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

When it asks "Do you want to change your default shell to zsh?" → type `y`

### 3.2 — Verify

```bash
echo $SHELL
```

Should show `/usr/bin/zsh` or `/bin/zsh`.

If not, set it manually:

```bash
chsh -s $(which zsh)
```

Then close and reopen your terminal.

### 3.3 — Why zsh?

- Better autocomplete than bash
- Oh My Zsh themes and plugins
- Same shell as macOS default
- Everything in this guide is tested on zsh

> **Important:** From now on, all config goes to `~/.zshrc`.
> Never run `source ~/.bashrc` — it will cause errors.
> Always use `source ~/.zshrc`.

---

## Step 4: Configure Git

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

## Step 5: Install GitHub CLI (gh)

### 5.1 — Install

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

### 5.2 — Login

```bash
gh auth login
```

Follow the prompts:
1. `GitHub.com`
2. `HTTPS`
3. `Login with a web browser`
4. Copy the one-time code shown in terminal
5. Press Enter → browser opens → paste code → authorize

### 5.3 — Verify

```bash
gh auth status
```

Should show: `Logged in to github.com`

---

## Step 6: Install Bun

```bash
curl -fsSL https://bun.sh/install | bash
```

The installer adds config to `~/.bashrc` by default. We need it in `~/.zshrc`:

```bash
grep -E 'bun|BUN' ~/.bashrc >> ~/.zshrc
```

```bash
source ~/.zshrc
```

Verify:

```bash
bun --version
```

---

## Step 7: Install Node.js

We use **fnm** (Fast Node Manager) — faster than nvm:

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

The installer adds config to `~/.bashrc`. Copy it to `~/.zshrc` and add zsh support:

```bash
grep -E 'fnm|FNM' ~/.bashrc >> ~/.zshrc
```

```bash
echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc
```

```bash
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
```

```bash
npm --version
```

---

## Step 8: Install Python 3

Usually pre-installed on Ubuntu 24.04. Check:

```bash
python3 --version
```

If not installed:

```bash
sudo apt install -y python3 python3-pip python3-venv
```

---

## Step 9: Install Claude Code

### 9.1 — Install

```bash
npm install -g @anthropic-ai/claude-code
```

### 9.2 — Verify

```bash
claude --version
```

### 9.3 — Login

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

## Step 10: Clone Your Oracle Repo

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
```

```bash
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME
```

```bash
gh repo create my-oracle --private --clone
```

```bash
cd my-oracle
```

Then later in Step 15 you'll use `/awaken` to create your Oracle identity.

---

## Step 11: Install Oracle Skills

```bash
~/.bun/bin/bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y
```

Verify:

```bash
ls ~/.claude/skills/
```

You should see folders like: `recap`, `standup`, `trace`, `rrr`, `forward`, `feel`, etc.

---

## Step 12: Setup tmux (Always-On Sessions)

tmux lets your Oracle keep running even when you close the terminal.

### 12.1 — Create tmux config

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

### 12.2 — tmux Cheat Sheet

| Action | How |
|--------|-----|
| **Start new session** | `tmux new-session -s oracle` |
| **Detach** (leave running) | `Ctrl+B` then `D` |
| **Reattach** (come back) | `tmux attach -t oracle` |
| **List sessions** | `tmux list-sessions` |
| **Kill session** | `tmux kill-session -t oracle` |
| **Scroll up** | `Ctrl+B` then `[` then arrow keys, `q` to exit |

### 12.3 — How it works

```
You start Claude in tmux:
  tmux new-session -s oracle → claude

You detach (Ctrl+B, D):
  Terminal closes, but Claude is STILL RUNNING

You come back later:
  tmux attach -t oracle → Claude is right where you left it!
```

---

## Step 13: VS Code Integration

From Ubuntu terminal, open your Oracle repo:

```bash
code ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
```

- VS Code will auto-install the **WSL extension**
- You're now editing files directly on the Linux filesystem
- Terminal in VS Code = Ubuntu terminal (zsh)

---

## Step 14: Verify Everything

```bash
echo ""
echo "==============================="
echo "  Oracle WSL2 Health Check"
echo "==============================="
echo ""
echo "  Shell:   $SHELL"
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

**Expected:** All items show a version, Shell = zsh, Skills > 20.

---

## Step 15: First Run!

```bash
tmux new-session -s oracle
```

```bash
cd ~/ghq/github.com/YOUR_GITHUB_USERNAME/YOUR_ORACLE_REPO
```

```bash
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
wsl
```

```bash
tmux attach -t oracle || tmux new-session -s oracle
```

```bash
cd ~/ghq/github.com/YOUR_USERNAME/YOUR_ORACLE
```

```bash
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

```powershell
wsl --list --verbose
```

If VERSION = 1:

```powershell
wsl --set-version Ubuntu-24.04 2
```

### Claude Code login doesn't open browser

```bash
claude login --method device-code
```

### gh auth not working

1. Go to https://github.com/settings/tokens
2. Generate new token (classic) with `repo` scope
3. Run:

```bash
gh auth login --with-token
```

### "command not found" after installing bun/node/fnm

```bash
source ~/.zshrc
```

If still not found, copy config from bashrc:

```bash
grep -E 'bun|fnm|BUN|FNM' ~/.bashrc >> ~/.zshrc
```

```bash
source ~/.zshrc
```

### `shopt: command not found`

You accidentally ran `source ~/.bashrc` in zsh. `shopt` is bash-only.

**Fix:** Just don't run it. Use this instead:

```bash
source ~/.zshrc
```

### Accessing Windows files from WSL

```bash
ls /mnt/c/Users/YourWindowsUsername/
```

> **Important:** Files on `/mnt/c/` are slower. Always keep your Oracle repo on the Linux filesystem (`~/`).

### tmux session gone after Windows restart

WSL sessions don't survive Windows restarts. After restarting:

```bash
wsl
```

```bash
tmux new-session -s oracle
```

```bash
cd ~/ghq/github.com/YOUR_USERNAME/YOUR_ORACLE
```

```bash
claude
```

Then `/recap` to reorient.

### npm permission errors (EACCES)

```bash
mkdir -p ~/.npm-global
```

```bash
npm config set prefix '~/.npm-global'
```

```bash
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
```

```bash
source ~/.zshrc
```

```bash
npm install -g @anthropic-ai/claude-code
```

---

## Do I need Homebrew?

**No.** Ubuntu has `apt` which is faster and more native. Everything in this guide installs without Homebrew.

| Tool | Mac uses | Ubuntu uses |
|------|----------|-------------|
| Package manager | `brew` | `apt` |
| Bun | `curl` installer | `curl` installer (same) |
| Node | `brew install node` or `fnm` | `fnm` (same) |
| Git | `brew install git` | `apt install git` |
| gh | `brew install gh` | `apt install gh` |

---

## Why WSL2?

| Feature | Windows | WSL2 Ubuntu |
|---------|---------|-------------|
| Dev tool speed | Normal | 2-5x faster |
| Always-on (tmux) | Not possible | Yes |
| Linux compatibility | Limited | Full |
| VS Code support | Native | Via Remote-WSL |
| File system | NTFS (slower) | ext4 (fast) |
| Shell | PowerShell | zsh (modern) |
| Docker | Docker Desktop | Native |

---

## Architecture

```
┌─────────────────────────────────────────┐
│              Windows 11                  │
│                                          │
│  ┌──────────┐  ┌──────────────────────┐ │
│  │ VS Code  │  │     WSL2 Ubuntu      │ │
│  │          ├──┤                      │ │
│  │ (editor) │  │  zsh + Oh My Zsh    │ │
│  │          │  │  tmux ─── claude     │ │
│  └──────────┘  │    │                 │ │
│                │    └── Oracle repo   │ │
│  ┌──────────┐  │        ├── CLAUDE.md │ │
│  │ Browser  │  │        ├── skills/   │ │
│  │ (GitHub) │  │        └── memory/   │ │
│  └──────────┘  └──────────────────────┘ │
└─────────────────────────────────────────┘
```

---

## Links

- [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- [Oracle Skills CLI](https://github.com/Soul-Brews-Studio/oracle-skills-cli)
- [Oracle Philosophy](https://github.com/Soul-Brews-Studio/oracle-v2)
- [Oh My Zsh](https://ohmyz.sh/)
- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [Windows Terminal](https://aka.ms/terminal)

---

*Made with Oracle philosophy: Nothing is deleted, everything is remembered.*
