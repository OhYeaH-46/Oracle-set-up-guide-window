# Oracle Quick Start — Windows (WSL2)

> Zero to Oracle in ~45 minutes. Two scripts, minimal interaction.
>
> Full guide with explanations: [Path C: WSL2 Full Setup](path-c-wsl2.md)

---

## Option A: Run the Scripts (Recommended)

### Prerequisites

1. **WSL2 + Ubuntu** — Open PowerShell as Admin:
   ```powershell
   wsl --install -d Ubuntu-24.04
   ```
   Restart PC. Create username + password when Ubuntu opens.

2. **Accounts** — [GitHub](https://github.com/signup) + [Anthropic](https://www.anthropic.com/pricing) (paid plan)

### Step 1: Machine Setup (run once)

In Ubuntu terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/OhYeaH-46/Oracle-set-up-guide-window/master/setup-machine.sh -o setup-machine.sh && \
chmod +x setup-machine.sh && ./setup-machine.sh
```

Close and reopen terminal after it finishes. Then login to Claude Code:

```bash
claude
# login when prompted, then type /exit
```

### Step 2: Create Oracle

```bash
curl -fsSL https://raw.githubusercontent.com/OhYeaH-46/Oracle-set-up-guide-window/master/create-oracle.sh -o create-oracle.sh && \
chmod +x create-oracle.sh && ./create-oracle.sh
```

### Step 3: Awaken

The script tells you what to do next:

```bash
cd ~/ghq/github.com/YOUR_USERNAME/my-oracle
claude --dangerously-skip-permissions
```

Inside Claude Code:

```
/awaken
```

Answer questions. ~20 min. Done!

---

## Option B: Manual Copy-Paste

<details>
<summary>Click to expand manual steps</summary>

### Prerequisites

- Windows 10 (Build 19041+) or 11
- GitHub account ([signup](https://github.com/signup))
- Anthropic account with paid plan ([pricing](https://www.anthropic.com/pricing))
- WSL2 installed (`wsl --install -d Ubuntu-24.04` in PowerShell Admin, then restart)

### Part 1: Machine Setup

#### 1. Update system + install essentials

```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install -y build-essential curl wget unzip zip git \
  ca-certificates gnupg lsb-release software-properties-common \
  tmux htop jq zsh python3 python3-pip python3-venv wslu
```

#### 2. Oh My Zsh + plugins

```bash
# Install Oh My Zsh (type 'y' when asked)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

After install (now in zsh):

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting z sudo copypath command-not-found history)/' ~/.zshrc && \
sed -i 's/^# export PATH=$HOME\/bin/export PATH=$HOME\/bin/' ~/.zshrc && \
echo 'export BROWSER=wslview' >> ~/.zshrc && \
source ~/.zshrc
```

#### 3. Git config

```bash
git config --global user.name "YOUR_GITHUB_USERNAME" && \
git config --global user.email "YOUR_ID+YOUR_USERNAME@users.noreply.github.com" && \
git config --global init.defaultBranch master
```

#### 4. GitHub CLI

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

```bash
gh auth login
```

#### 5. Bun + Node.js + ghq

```bash
# Bun
curl -fsSL https://bun.sh/install | bash && \
grep -E 'bun|BUN' ~/.bashrc >> ~/.zshrc && source ~/.zshrc

# Node.js
curl -fsSL https://fnm.vercel.app/install | bash && \
grep -E 'fnm|FNM' ~/.bashrc >> ~/.zshrc && \
echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc && \
source ~/.zshrc && fnm install 22 && fnm default 22

# ghq
GHQ_VER=$(curl -s https://api.github.com/repos/x-motemen/ghq/releases/latest | jq -r .tag_name) && \
curl -sL "https://github.com/x-motemen/ghq/releases/download/${GHQ_VER}/ghq_linux_amd64.zip" -o /tmp/ghq.zip && \
unzip -o /tmp/ghq.zip -d /tmp/ghq && \
sudo mv /tmp/ghq/ghq_linux_amd64/ghq /usr/local/bin/ && \
rm -rf /tmp/ghq /tmp/ghq.zip && \
git config --global ghq.root ~/ghq
```

#### 6. Claude Code

```bash
npm install -g @anthropic-ai/claude-code && claude --version
```

```bash
claude    # login, then /exit
```

### Part 2: Create Oracle

```bash
# Create repo
gh repo create my-oracle --private

# Clone (replace YOUR_USERNAME)
ghq get https://github.com/YOUR_USERNAME/my-oracle && \
cd ~/ghq/github.com/YOUR_USERNAME/my-oracle

# Install skills
~/.bun/bin/bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y

# Awaken
claude --dangerously-skip-permissions
# Type: /awaken
```

### Part 3: Post-Setup

```bash
# tmux config
cat > ~/.tmux.conf << 'EOF'
set -g mouse on
set -g history-limit 50000
set -g default-terminal "screen-256color"
set -g status-style 'bg=#333333 fg=#ffffff'
set -g status-left ' Oracle '
set -g status-right ' %H:%M '
EOF

# Aliases (replace YOUR_USERNAME and my-oracle)
echo "alias my-oracle='cd ~/ghq/github.com/YOUR_USERNAME/my-oracle && claude --dangerously-skip-permissions'" >> ~/.zshrc
echo "alias my-oracle-tmux='tmux attach -t oracle 2>/dev/null || tmux new-session -s oracle -c ~/ghq/github.com/YOUR_USERNAME/my-oracle \"claude --dangerously-skip-permissions\"'" >> ~/.zshrc
source ~/.zshrc

# Claude settings
claude config set autoCompact disabled
claude config set model claude-opus-4-6
```

</details>

---

## Daily Workflow

```
my-oracle       # or my-oracle-tmux
/recap          # start
... work ...
/rrr            # end
```

## Quick Troubleshooting

| Problem | Fix |
|---------|-----|
| "command not found" | `source ~/.zshrc` |
| Browser won't open | `claude login --method device-code` |
| Skills not showing | `/exit` → restart `claude` |
| npm EACCES | `mkdir -p ~/.npm-global && npm config set prefix '~/.npm-global' && echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc && source ~/.zshrc` |

---

> Full guide: [path-c-wsl2.md](path-c-wsl2.md) · [Writing CLAUDE.md](writing-claude-md.md) · [Oracle Skills](https://github.com/Soul-Brews-Studio/oracle-skills-cli)
