# Oracle Quick Start (30 นาที)

> Copy-paste ทีละ block ทำตามลำดับ

## 1. WSL2 (PowerShell Admin)

```powershell
wsl --install -d Ubuntu-24.04
```
Restart เครื่อง ตั้ง username + password

## 2. เครื่องมือ (Ubuntu terminal)

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl wget git tmux jq unzip zsh python3

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Bun
curl -fsSL https://bun.sh/install | bash && source ~/.zshrc

# Node.js
curl -fsSL https://fnm.vercel.app/install | bash && source ~/.zshrc
fnm install 22 && fnm default 22

# GitHub CLI
(type -p wget >/dev/null || sudo apt-get install wget -y) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update && sudo apt install gh -y
gh auth login

# ghq
GHQ_VERSION=$(curl -s https://api.github.com/repos/x-motemen/ghq/releases/latest | jq -r .tag_name | sed 's/^v//')
wget -q "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_amd64.zip" -O /tmp/ghq.zip
unzip -o /tmp/ghq.zip -d /tmp/ghq && sudo mv /tmp/ghq/ghq_linux_amd64/ghq /usr/local/bin/
git config --global ghq.root ~/ghq

# Claude Code
npm install -g @anthropic-ai/claude-code
```

## 3. Git

```bash
git config --global user.name "YOUR_GITHUB_USERNAME"
git config --global user.email "YOUR_USERNAME@users.noreply.github.com"
git config --global init.defaultBranch master
```

## 4. Oracle repo

```bash
ORACLE_NAME="my-oracle"  # เปลี่ยนชื่อตามต้องการ
gh repo create "$ORACLE_NAME" --private --clone
cd "$ORACLE_NAME"
```

## 5. Skills

```bash
~/.bun/bin/bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y
```

## 6. Awaken

```bash
claude --dangerously-skip-permissions
# พิมพ์: /awaken
# ทำตามขั้นตอน (~15-20 นาที)
# ตรวจ: /who-are-you, /philosophy, /recap
```

## 7. Alias + Daily Workflow

```bash
echo "alias my-oracle='cd $(pwd) && claude'" >> ~/.zshrc && source ~/.zshrc
# ใช้ทุกวัน: my-oracle → /recap → ทำงาน → /rrr → ออก
```

## Fix

| ปัญหา | แก้ |
|-------|-----|
| `claude` ไม่เจอ | `source ~/.zshrc` |
| `bunx` ไม่เจอ | ใช้ `~/.bun/bin/bunx` |
| Skills ไม่โหลด | Restart Claude Code |
| Awaken ค้าง | Ctrl+C แล้ว `/awaken` ใหม่ |
