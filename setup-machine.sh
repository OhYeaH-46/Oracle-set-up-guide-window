#!/bin/bash
# =============================================================
# Oracle Machine Setup — Part 1 of 2
# Run this ONCE on a fresh WSL2 Ubuntu to install all tools.
#
# Prerequisites:
#   1. WSL2 + Ubuntu installed (PowerShell Admin: wsl --install -d Ubuntu-24.04)
#   2. GitHub account + Anthropic paid account
#
# Usage:
#   chmod +x setup-machine.sh && ./setup-machine.sh
# =============================================================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${YELLOW}→${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; exit 1; }

echo ""
echo "========================================"
echo "  Oracle Machine Setup (Part 1 of 2)"
echo "========================================"
echo ""

# ----------------------------------------------------------
# 1. System update + essentials
# ----------------------------------------------------------
info "Updating system and installing essentials..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  build-essential curl wget unzip zip git \
  ca-certificates gnupg lsb-release software-properties-common \
  tmux htop jq zsh python3 python3-pip python3-venv wslu
ok "System packages installed"

# ----------------------------------------------------------
# 2. Oh My Zsh + plugins
# ----------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no CHSH=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ok "Oh My Zsh installed"
else
  ok "Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
ok "Zsh plugins installed"

# Configure .zshrc plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting z sudo copypath command-not-found history)/' ~/.zshrc 2>/dev/null || true

# Uncomment PATH line
sed -i 's/^# export PATH=$HOME\/bin/export PATH=$HOME\/bin/' ~/.zshrc 2>/dev/null || true

# Add BROWSER for WSL
grep -q 'BROWSER=wslview' ~/.zshrc 2>/dev/null || echo 'export BROWSER=wslview' >> ~/.zshrc

ok "Zsh configured"

# ----------------------------------------------------------
# 3. Git config (interactive)
# ----------------------------------------------------------
if [ -z "$(git config --global user.name 2>/dev/null)" ]; then
  echo ""
  read -p "GitHub username: " GH_USER
  read -p "GitHub noreply email (find at github.com/settings/emails): " GH_EMAIL
  git config --global user.name "$GH_USER"
  git config --global user.email "$GH_EMAIL"
fi
git config --global init.defaultBranch master
ok "Git configured: $(git config --global user.name)"

# ----------------------------------------------------------
# 4. GitHub CLI
# ----------------------------------------------------------
if ! command -v gh &>/dev/null; then
  info "Installing GitHub CLI..."
  (type -p wget >/dev/null || sudo apt-get install wget -y) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O"$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
  ok "GitHub CLI installed"
else
  ok "GitHub CLI already installed"
fi

if ! gh auth status &>/dev/null; then
  info "Login to GitHub..."
  gh auth login
fi
ok "GitHub authenticated: $(gh auth status 2>&1 | grep 'Logged in' | head -1)"

# ----------------------------------------------------------
# 5. Bun
# ----------------------------------------------------------
if ! command -v bun &>/dev/null && [ ! -f "$HOME/.bun/bin/bun" ]; then
  info "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  grep -E 'bun|BUN' ~/.bashrc >> ~/.zshrc 2>/dev/null || true
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  ok "Bun installed: $($HOME/.bun/bin/bun --version)"
else
  ok "Bun already installed"
fi

# ----------------------------------------------------------
# 6. Node.js via fnm
# ----------------------------------------------------------
if ! command -v node &>/dev/null; then
  info "Installing Node.js via fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash
  grep -E 'fnm|FNM' ~/.bashrc >> ~/.zshrc 2>/dev/null || true
  grep -q 'fnm env' ~/.zshrc || echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc

  # Load fnm for current session
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell bash 2>/dev/null)" || true

  fnm install 22
  fnm default 22
  ok "Node.js installed: $(node --version)"
else
  ok "Node.js already installed: $(node --version)"
fi

# ----------------------------------------------------------
# 7. ghq
# ----------------------------------------------------------
if ! command -v ghq &>/dev/null; then
  info "Installing ghq..."
  GHQ_VER=$(curl -s https://api.github.com/repos/x-motemen/ghq/releases/latest | jq -r .tag_name)
  curl -sL "https://github.com/x-motemen/ghq/releases/download/${GHQ_VER}/ghq_linux_amd64.zip" -o /tmp/ghq.zip
  unzip -o /tmp/ghq.zip -d /tmp/ghq
  sudo mv /tmp/ghq/ghq_linux_amd64/ghq /usr/local/bin/
  rm -rf /tmp/ghq /tmp/ghq.zip
  ok "ghq installed"
else
  ok "ghq already installed"
fi
git config --global ghq.root ~/ghq

# Add gq shortcut if not present
if ! grep -q 'gq ()' ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc << 'ZSHEOF'

# gq — clone any GitHub URL with ghq and cd into it
gq () {
  local url="$1"
  url=$(echo "$url" | sed 's|/tree/[^/]*$||' | sed 's|/blob/.*$||')
  local repo_path=$(echo "$url" | sed 's|https://github.com/||' | sed 's|git@github.com:||' | sed 's|\.git$||')
  local full_path="$HOME/ghq/github.com/$repo_path"
  ghq get -u "$url" && cd "$full_path"
}
ZSHEOF
  ok "gq shortcut added to .zshrc"
fi

# ----------------------------------------------------------
# 8. Claude Code
# ----------------------------------------------------------
if ! command -v claude &>/dev/null; then
  info "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
  ok "Claude Code installed: $(claude --version 2>&1)"
else
  ok "Claude Code already installed: $(claude --version 2>&1)"
fi

# ----------------------------------------------------------
# 9. tmux config
# ----------------------------------------------------------
if [ ! -f "$HOME/.tmux.conf" ]; then
  cat > ~/.tmux.conf << 'EOF'
set -g mouse on
set -g history-limit 50000
set -g default-terminal "screen-256color"
set -g status-style 'bg=#333333 fg=#ffffff'
set -g status-left ' Oracle '
set -g status-right ' %H:%M '
EOF
  ok "tmux configured"
else
  ok "tmux config already exists"
fi

# ----------------------------------------------------------
# Final check
# ----------------------------------------------------------
echo ""
echo "========================================"
echo "  Environment Check"
echo "========================================"
echo ""
echo "  Shell:   $SHELL"
echo "  Git:     $(git --version 2>/dev/null || echo 'MISSING')"
echo "  gh:      $(gh --version 2>/dev/null | head -1 || echo 'MISSING')"
echo "  Bun:     $($HOME/.bun/bin/bun --version 2>/dev/null || bun --version 2>/dev/null || echo 'MISSING')"
echo "  Node:    $(node --version 2>/dev/null || echo 'MISSING')"
echo "  npm:     $(npm --version 2>/dev/null || echo 'MISSING')"
echo "  Python:  $(python3 --version 2>/dev/null || echo 'MISSING')"
echo "  ghq:     $(ghq --version 2>/dev/null || echo 'MISSING')"
echo "  Claude:  $(claude --version 2>&1 || echo 'MISSING')"
echo "  tmux:    $(tmux -V 2>/dev/null || echo 'MISSING')"
echo ""
echo "========================================"
echo ""

if echo "$SHELL" | grep -q "bash"; then
  echo -e "${YELLOW}NOTE: Your shell is still bash. Run: chsh -s \$(which zsh)${NC}"
  echo -e "${YELLOW}Then close and reopen terminal.${NC}"
  echo ""
fi

echo -e "${GREEN}Part 1 complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Close and reopen terminal (to activate zsh)"
echo "  2. Login to Claude Code:  claude  (then /exit after login)"
echo "  3. Run Part 2:  ./create-oracle.sh"
echo ""
