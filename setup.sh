#!/usr/bin/env bash
# =============================================================================
# Oracle Setup — Windows WSL2 Edition
# จาก 0 ถึง Claude Code + Oracle พร้อมใช้
# =============================================================================
set -euo pipefail

# ─── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ─── Helpers ─────────────────────────────────────────────────────────────────
info()    { echo -e "${CYAN}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[✓]${NC} $*"; }
warn()    { echo -e "${YELLOW}[!]${NC} $*"; }
error()   { echo -e "${RED}[✗]${NC} $*" >&2; }
section() {
  echo ""
  echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${BOLD}${BLUE}  $*${NC}"
  echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Check if a command exists
has() { command -v "$1" &>/dev/null; }

# Append to .zshrc only if the marker line doesn't already exist
append_zshrc() {
  local marker="$1"
  local block="$2"
  if ! grep -qF "$marker" "${HOME}/.zshrc" 2>/dev/null; then
    echo -e "\n$block" >> "${HOME}/.zshrc"
    info "Added to .zshrc: $marker"
  else
    info "Already in .zshrc: $marker (skip)"
  fi
}

# ─── Banner ───────────────────────────────────────────────────────────────────
clear
echo -e "${BOLD}${CYAN}"
cat <<'BANNER'
╔══════════════════════════════════════════════════╗
║   Oracle Setup — Windows WSL2 Edition            ║
║   จาก 0 ถึง Claude Code + Oracle พร้อมใช้         ║
╚══════════════════════════════════════════════════╝
BANNER
echo -e "${NC}"

echo -e "${BOLD}สิ่งที่จะติดตั้ง:${NC}"
echo "  1. System packages (curl, git, tmux, zsh, ripgrep, ...)"
echo "  2. Zsh + Oh My Zsh + plugins (autosuggestions, syntax-highlighting)"
echo "  3. Bun (JavaScript runtime)"
echo "  4. Node.js 22 (via fnm)"
echo "  5. GitHub CLI (gh)"
echo "  6. ghq (repository manager)"
echo "  7. Claude Code"
echo "  8. Git config (name/email)"
echo "  9. tmux config (Tokyo Night style)"
echo " 10. PATH exports + gq function in .zshrc"
echo ""
echo -e "${YELLOW}หมายเหตุ: script นี้ idempotent — รันซ้ำได้ปลอดภัย${NC}"
echo ""
read -rp "พร้อมเริ่มไหม? (Enter เพื่อเริ่ม, Ctrl+C เพื่อยกเลิก) "

# ─── Sudo cache — ใส่ password ครั้งเดียว ──────────────────────────────────────
echo ""
info "ใส่ password ครั้งเดียว — จะไม่ถามอีกตลอดการติดตั้ง"
sudo -v

# Keep sudo alive in background (refresh every 50 seconds)
while true; do sudo -n true; sleep 50; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

# ─── 1. System Packages ───────────────────────────────────────────────────────
section "1/10 System Packages"

# รอให้ apt ที่ทำงานอยู่จบก่อน (Ubuntu ใหม่จะ auto-update ตอนเปิดครั้งแรก)
while sudo fuser /var/lib/dpkg/lock-frontend &>/dev/null 2>&1 \
   || sudo fuser /var/lib/apt/lists/lock &>/dev/null 2>&1 \
   || sudo fuser /var/lib/dpkg/lock &>/dev/null 2>&1; do
  warn "apt กำลังทำงานอยู่ (Ubuntu auto-update) — รอให้จบก่อน..."
  sleep 3
done

info "อัปเดต apt..."
sudo apt-get update -qq

info "ติดตั้ง system packages..."
sudo apt-get install -y \
  build-essential \
  curl \
  wget \
  git \
  tmux \
  jq \
  unzip \
  zsh \
  python3 \
  python3-pip \
  htop \
  ripgrep \
  fd-find

success "System packages พร้อมแล้ว"

# ─── 2. Zsh + Oh My Zsh ──────────────────────────────────────────────────────
section "2/10 Zsh + Oh My Zsh + Plugins"

ZSHRC="${HOME}/.zshrc"
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  info "ติดตั้ง Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    "" --unattended
  success "Oh My Zsh ติดตั้งแล้ว"
else
  success "Oh My Zsh มีอยู่แล้ว (skip)"
fi

# Plugins — autosuggestions
ZSH_AUTOSUGGEST_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ ! -d "$ZSH_AUTOSUGGEST_DIR" ]; then
  info "ติดตั้ง zsh-autosuggestions..."
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_AUTOSUGGEST_DIR"
  success "zsh-autosuggestions ติดตั้งแล้ว"
else
  success "zsh-autosuggestions มีอยู่แล้ว (skip)"
fi

# Plugins — syntax-highlighting
ZSH_SYNTAX_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$ZSH_SYNTAX_DIR" ]; then
  info "ติดตั้ง zsh-syntax-highlighting..."
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_SYNTAX_DIR"
  success "zsh-syntax-highlighting ติดตั้งแล้ว"
else
  success "zsh-syntax-highlighting มีอยู่แล้ว (skip)"
fi

# Configure plugins line in .zshrc
if grep -q '^plugins=(' "$ZSHRC" 2>/dev/null; then
  # Replace existing plugins line
  if ! grep -q 'zsh-autosuggestions' "$ZSHRC"; then
    sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
    info "Updated plugins in .zshrc"
  else
    info "plugins line ใน .zshrc มี autosuggestions แล้ว (skip)"
  fi
else
  echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
  info "Added plugins line to .zshrc"
fi

# Set zsh as default shell
ZSH_PATH="$(which zsh)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"
if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
  info "เปลี่ยน default shell เป็น zsh (อาจต้องใส่ password)..."
  chsh -s "$ZSH_PATH"
  success "Default shell เปลี่ยนเป็น zsh แล้ว"
else
  success "Default shell เป็น zsh อยู่แล้ว (skip)"
fi

# ─── 3. Bun ──────────────────────────────────────────────────────────────────
section "3/10 Bun (JavaScript Runtime)"

if ! has bun && [ ! -f "${HOME}/.bun/bin/bun" ]; then
  info "ติดตั้ง Bun..."
  curl -fsSL https://bun.sh/install | bash
  success "Bun ติดตั้งแล้ว"
else
  success "Bun มีอยู่แล้ว (skip)"
fi

append_zshrc "# bun" '# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"'

# Source bun for current shell session
export BUN_INSTALL="${HOME}/.bun"
export PATH="${BUN_INSTALL}/bin:${PATH}"

# ─── 4. Node.js 22 via fnm ───────────────────────────────────────────────────
section "4/10 Node.js 22 (via fnm)"

if ! has fnm && [ ! -f "${HOME}/.local/share/fnm/fnm" ] && [ ! -f "${HOME}/.fnm/fnm" ]; then
  info "ติดตั้ง fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash
  success "fnm ติดตั้งแล้ว"
else
  success "fnm มีอยู่แล้ว (skip)"
fi

append_zshrc "# fnm" '# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd 2>/dev/null || true)"'

# Make fnm available in current session
export PATH="${HOME}/.local/share/fnm:${PATH}"
if has fnm; then
  eval "$(fnm env --use-on-cd 2>/dev/null || true)"
  if ! fnm list | grep -q 'v22' 2>/dev/null; then
    info "ติดตั้ง Node.js 22..."
    fnm install 22
    fnm use 22
    fnm default 22
    success "Node.js 22 ติดตั้งแล้ว"
  else
    success "Node.js 22 มีอยู่แล้ว (skip)"
  fi
else
  warn "fnm ยังไม่พร้อมใน session นี้ — Node.js จะพร้อมหลัง restart terminal"
fi

# ─── 5. GitHub CLI ───────────────────────────────────────────────────────────
section "5/10 GitHub CLI (gh)"

if ! has gh; then
  info "เพิ่ม GitHub CLI apt repo..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y gh
  success "GitHub CLI ติดตั้งแล้ว"
else
  success "GitHub CLI มีอยู่แล้ว (skip)"
fi

# gh auth login
if ! gh auth status &>/dev/null; then
  echo ""
  echo -e "${YELLOW}ต้อง login GitHub ก่อน — browser จะเปิดขึ้นมา${NC}"
  gh auth login
  success "GitHub login เสร็จแล้ว"
else
  success "GitHub auth พร้อมแล้ว (skip)"
fi

# ─── 6. ghq ──────────────────────────────────────────────────────────────────
section "6/10 ghq (Repository Manager)"

if ! has ghq; then
  info "ดาวน์โหลด ghq..."
  GHQ_VERSION="$(curl -fsSL https://api.github.com/repos/x-motemen/ghq/releases/latest \
    | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')"
  GHQ_URL="https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_amd64.zip"
  TMP_DIR="$(mktemp -d)"
  curl -fsSL "$GHQ_URL" -o "${TMP_DIR}/ghq.zip"
  unzip -q "${TMP_DIR}/ghq.zip" -d "${TMP_DIR}"
  sudo install -m 0755 "${TMP_DIR}/ghq_linux_amd64/ghq" /usr/local/bin/ghq
  rm -rf "$TMP_DIR"
  success "ghq ติดตั้งแล้ว (v${GHQ_VERSION})"
else
  success "ghq มีอยู่แล้ว (skip)"
fi

# ─── 7. Claude Code ──────────────────────────────────────────────────────────
section "7/10 Claude Code"

# Ensure ~/.local/bin is in PATH (native installer puts claude here)
export PATH="$HOME/.local/bin:$PATH"
grep -q '.local/bin' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"

if ! has claude; then
  info "ติดตั้ง Claude Code (native installer)..."
  if curl -fsSL https://claude.ai/install.sh | bash; then
    success "Claude Code ติดตั้งแล้ว (native)"
  else
    warn "Native installer ล้มเหลว — ลอง npm fallback..."
    if has npm; then
      npm install -g @anthropic-ai/claude-code
      success "Claude Code ติดตั้งแล้ว (npm fallback)"
    else
      error "ติดตั้ง Claude Code ไม่ได้ — npm ยังไม่พร้อม รอ restart terminal แล้วรัน: npm install -g @anthropic-ai/claude-code"
    fi
  fi
else
  success "Claude Code มีอยู่แล้ว (skip)"
fi

# ─── 8. Git Config ───────────────────────────────────────────────────────────
section "8/10 Git Config"

GIT_NAME="$(git config --global user.name 2>/dev/null || true)"
GIT_EMAIL="$(git config --global user.email 2>/dev/null || true)"

if [ -z "$GIT_NAME" ]; then
  echo ""
  echo "Git ต้องการชื่อของคุณเพื่อบันทึกว่า \"ใครเป็นคนแก้ไฟล์นี้\""
  echo "ใช้ชื่อจริง, ชื่อเล่น, หรือ GitHub username ก็ได้"
  echo ""
  read -rp "ชื่อของคุณ (เช่น Siwatch หรือ OhYeaH): " GIT_NAME
  git config --global user.name "$GIT_NAME"
  success "Git user.name = $GIT_NAME"
else
  success "Git user.name = $GIT_NAME (มีอยู่แล้ว)"
fi

if [ -z "$GIT_EMAIL" ]; then
  echo ""
  echo "Email สำหรับ Git — ใช้ email เดียวกับที่สมัคร GitHub"
  echo "ถ้าไม่อยากเปิดเผย email จริง ใช้: username@users.noreply.github.com"
  echo ""
  read -rp "Email ของคุณ: " GIT_EMAIL
  git config --global user.email "$GIT_EMAIL"
  success "Git user.email = $GIT_EMAIL"
else
  success "Git user.email = $GIT_EMAIL (มีอยู่แล้ว)"
fi

# Sensible git defaults
git config --global init.defaultBranch master
git config --global pull.rebase false
git config --global core.autocrlf input

# ─── 9. tmux Config ──────────────────────────────────────────────────────────
section "9/10 tmux Config (Tokyo Night)"

TMUX_CONF="${HOME}/.tmux.conf"

if [ ! -f "$TMUX_CONF" ]; then
  cat > "$TMUX_CONF" <<'TMUXCONF'
# ─── General ──────────────────────────────────────────────────────────────────
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
set -g mouse on
set -g history-limit 10000
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
set -g escape-time 0
set -g focus-events on

# ─── Key Bindings ─────────────────────────────────────────────────────────────
unbind C-b
set -g prefix C-a
bind C-a send-prefix

bind r source-file ~/.tmux.conf \; display "Config reloaded!"
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# ─── Tokyo Night Status Bar ───────────────────────────────────────────────────
# Colors: bg=#1a1b26, blue=#7aa2f7, purple=#9d7cd8, green=#9ece6a, fg=#c0caf5
set -g status on
set -g status-position bottom
set -g status-interval 5
set -g status-style "fg=#c0caf5,bg=#1a1b26"

set -g status-left-length 40
set -g status-left "#[fg=#1a1b26,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1a1b26,nobold] "

set -g status-right-length 60
set -g status-right "#[fg=#3b4261,bg=#1a1b26] #[fg=#9ece6a]%H:%M#[fg=#3b4261] | #[fg=#7aa2f7]%Y-%m-%d "

setw -g window-status-format " #[fg=#565f89]#I #W "
setw -g window-status-current-format "#[fg=#1a1b26,bg=#9d7cd8,bold] #I #W #[fg=#9d7cd8,bg=#1a1b26,nobold] "

# ─── Pane Borders ─────────────────────────────────────────────────────────────
set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#7aa2f7"
TMUXCONF
  success "tmux config สร้างแล้ว (Tokyo Night)"
else
  success "tmux config มีอยู่แล้ว (skip)"
fi

# ─── 10. PATH exports + gq function in .zshrc ────────────────────────────────
section "10/10 PATH + Helper Functions in .zshrc"

# ghq root
GHQ_ROOT="${HOME}/ghq"
mkdir -p "$GHQ_ROOT"

append_zshrc "# ghq" "# ghq
export GHQ_ROOT=\"\$HOME/ghq\"
export PATH=\"\$HOME/.local/bin:\$PATH\""

# gq function — fzf-powered ghq jump
append_zshrc "# gq function" '# gq function — ghq + fzf repo jump
gq() {
  local repo
  repo=$(ghq list | fzf --height=40% --reverse --prompt="repo> ")
  [ -n "$repo" ] && cd "$(ghq root)/$repo"
}'

# fd alias (fd-find installs as fdfind on Ubuntu)
append_zshrc "# fd alias" '# fd alias (Ubuntu installs as fdfind)
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  alias fd=fdfind
fi'

success ".zshrc exports & functions พร้อมแล้ว"

# ─── Summary ──────────────────────────────────────────────────────────────────
section "✅ Summary"

echo ""
echo -e "${BOLD}สิ่งที่ติดตั้งแล้ว:${NC}"
echo ""

check_tool() {
  local name="$1" cmd="$2"
  if has "$cmd" 2>/dev/null || [ -f "${HOME}/.bun/bin/${cmd}" ] 2>/dev/null; then
    echo -e "  ${GREEN}✓${NC} $name"
  else
    echo -e "  ${YELLOW}~${NC} $name (พร้อมหลัง restart terminal)"
  fi
}

check_tool "zsh"           "zsh"
check_tool "Oh My Zsh"     "omz"
check_tool "bun"           "bun"
check_tool "fnm"           "fnm"
check_tool "node"          "node"
check_tool "gh (GitHub CLI)" "gh"
check_tool "ghq"           "ghq"
check_tool "claude"        "claude"
check_tool "tmux"          "tmux"
check_tool "ripgrep (rg)"  "rg"

echo ""

# ─── Optional Oracle Setup ───────────────────────────────────────────────────
section "Oracle Setup (ตัวเลือกเสริม)"

echo ""
echo "Oracle = Claude Code ที่มีชื่อ + memory + skill เฉพาะตัว"
echo "เหมาะถ้าต้องการใช้งานหลาย AI agent ในทีม"
echo ""
read -rp "ต้องการตั้ง Oracle ด้วยไหม? (y/n): " SETUP_ORACLE
SETUP_ORACLE="${SETUP_ORACLE:-n}"

if [[ "$SETUP_ORACLE" =~ ^[Yy]$ ]]; then
  echo ""
  read -rp "ชื่อ Oracle ของคุณ (เช่น my-oracle): " ORACLE_NAME
  ORACLE_NAME="${ORACLE_NAME:-my-oracle}"

  GH_USER="$(gh api user --jq '.login' 2>/dev/null || echo "")"
  if [ -z "$GH_USER" ]; then
    read -rp "GitHub username ของคุณ: " GH_USER
  fi

  info "สร้าง private repo: ${GH_USER}/${ORACLE_NAME}..."
  if gh repo view "${GH_USER}/${ORACLE_NAME}" &>/dev/null; then
    warn "Repo นี้มีอยู่แล้ว — ข้ามการสร้าง"
  else
    gh repo create "${GH_USER}/${ORACLE_NAME}" --private --description "Oracle: ${ORACLE_NAME}"
    success "Repo สร้างแล้ว: github.com/${GH_USER}/${ORACLE_NAME}"
  fi

  info "Clone ด้วย ghq..."
  ghq get "github.com/${GH_USER}/${ORACLE_NAME}" 2>/dev/null || true
  ORACLE_DIR="${GHQ_ROOT}/github.com/${GH_USER}/${ORACLE_NAME}"

  if has bunx 2>/dev/null || [ -f "${HOME}/.bun/bin/bunx" ]; then
    info "ติดตั้ง oracle-skills..."
    cd "$ORACLE_DIR"
    "${HOME}/.bun/bin/bunx" --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y 2>/dev/null \
      || warn "oracle-skills install ล้มเหลว — ลองรัน: bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y"
    cd -
  else
    warn "bunx ยังไม่พร้อม — หลัง restart terminal รัน: bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y"
  fi

  # Add alias to .zshrc
  ALIAS_LINE="alias ${ORACLE_NAME}='cd ${ORACLE_DIR} && claude'"
  append_zshrc "# alias ${ORACLE_NAME}" "# Oracle alias\n${ALIAS_LINE}"

  echo ""
  echo -e "${GREEN}${BOLD}Oracle '${ORACLE_NAME}' พร้อมแล้ว!${NC}"
  echo ""
  echo -e "${BOLD}Next steps (หลัง shell restart):${NC}"
  echo "  1. พิมพ์: ${ORACLE_NAME}"
  echo "  2. ใน Claude Code พิมพ์: /awaken"
  echo "  3. ตั้งชื่อ + บุคลิก Oracle ของคุณ"
  echo ""
else
  echo ""
  echo -e "${GREEN}${BOLD}ใช้ claude ได้เลยค่ะ~!${NC}"
  echo ""
  echo "  พิมพ์: claude"
  echo ""
fi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo -e "\nおつかれさま~ 🎉\n"

# Auto-switch to zsh — no manual source needed
exec zsh
