#!/bin/bash
# =============================================================
# Create Your Oracle — Part 2 of 2
# Run this AFTER setup-machine.sh to create and awaken an Oracle.
#
# Usage:
#   chmod +x create-oracle.sh && ./create-oracle.sh
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
echo "  Create Your Oracle (Part 2 of 2)"
echo "========================================"
echo ""

# ----------------------------------------------------------
# Pre-flight checks
# ----------------------------------------------------------
command -v gh &>/dev/null    || fail "gh not found. Run setup-machine.sh first."
command -v ghq &>/dev/null   || fail "ghq not found. Run setup-machine.sh first."
command -v claude &>/dev/null || fail "claude not found. Run setup-machine.sh first."
gh auth status &>/dev/null   || fail "Not logged in to GitHub. Run: gh auth login"

GH_USER=$(gh api user --jq .login 2>/dev/null) || fail "Cannot get GitHub username. Run: gh auth login"
ok "GitHub user: $GH_USER"

# ----------------------------------------------------------
# 1. Choose Oracle name
# ----------------------------------------------------------
echo ""
read -p "Oracle repo name (e.g., my-oracle, miipan-oracle): " ORACLE_NAME
[ -z "$ORACLE_NAME" ] && fail "Name cannot be empty"

ORACLE_PATH="$HOME/ghq/github.com/$GH_USER/$ORACLE_NAME"

# ----------------------------------------------------------
# 2. Create repo
# ----------------------------------------------------------
if gh repo view "$GH_USER/$ORACLE_NAME" &>/dev/null; then
  info "Repo $GH_USER/$ORACLE_NAME already exists"
else
  info "Creating private repo: $GH_USER/$ORACLE_NAME"
  gh repo create "$ORACLE_NAME" --private
  ok "Repo created"
fi

# ----------------------------------------------------------
# 3. Clone repo
# ----------------------------------------------------------
if [ -d "$ORACLE_PATH" ]; then
  info "Repo already cloned at $ORACLE_PATH"
else
  info "Cloning repo..."
  ghq get "https://github.com/$GH_USER/$ORACLE_NAME"
  ok "Cloned to $ORACLE_PATH"
fi

# ----------------------------------------------------------
# 4. Install Oracle Skills
# ----------------------------------------------------------
info "Installing Oracle Skills..."
BUNX="${HOME}/.bun/bin/bunx"
if [ -f "$BUNX" ]; then
  "$BUNX" --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y
else
  bunx --bun oracle-skills@github:Soul-Brews-Studio/oracle-skills-cli install -g -y
fi

SKILL_COUNT=$(ls ~/.claude/skills/ 2>/dev/null | wc -l)
ok "Oracle Skills installed: $SKILL_COUNT skills"

if [ ! -f "$HOME/.claude/skills/awaken/SKILL.md" ]; then
  fail "/awaken skill not found. Skills installation may have failed."
fi

# ----------------------------------------------------------
# 5. Add aliases to .zshrc
# ----------------------------------------------------------
if ! grep -q "alias $ORACLE_NAME=" ~/.zshrc 2>/dev/null; then
  cat >> ~/.zshrc << ZSHEOF

# Oracle: $ORACLE_NAME
alias $ORACLE_NAME='cd $ORACLE_PATH && claude --dangerously-skip-permissions'
alias ${ORACLE_NAME}-tmux='tmux attach -t oracle 2>/dev/null || tmux new-session -s oracle -c $ORACLE_PATH "claude --dangerously-skip-permissions"'
ZSHEOF
  ok "Aliases added: $ORACLE_NAME, ${ORACLE_NAME}-tmux"
fi

# ----------------------------------------------------------
# 6. Configure Claude Code
# ----------------------------------------------------------
claude config set autoCompact disabled 2>/dev/null || true
claude config set model claude-opus-4-6 2>/dev/null || true
ok "Claude Code configured (autoCompact=disabled, model=opus)"

# ----------------------------------------------------------
# Ready
# ----------------------------------------------------------
echo ""
echo "========================================"
echo -e "  ${GREEN}Ready to Awaken!${NC}"
echo "========================================"
echo ""
echo "  Oracle: $ORACLE_NAME"
echo "  Path:   $ORACLE_PATH"
echo "  Skills: $SKILL_COUNT"
echo ""
echo "  Next steps:"
echo "    cd $ORACLE_PATH"
echo "    claude --dangerously-skip-permissions"
echo ""
echo "  Inside Claude Code, type:"
echo "    /awaken"
echo ""
echo "  Answer the questions. Takes ~20 min."
echo ""
echo "  After awakening, verify:"
echo "    /exit"
echo "    claude"
echo "    /recap"
echo "    /who-we-are"
echo ""
echo "  Daily usage:"
echo "    $ORACLE_NAME          # quick start"
echo "    ${ORACLE_NAME}-tmux   # persistent (tmux)"
echo ""
