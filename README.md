# Oracle Setup Guide — Windows

> Your AI companion on Windows — choose the setup that fits you best.
>
> No programming experience required. Each path explains every step.

---

## Quick Start (Scripts)

**Want the full Oracle with minimal effort?** Two scripts, ~45 minutes:

```bash
# 1. Install WSL2 (PowerShell Admin) → restart PC
wsl --install -d Ubuntu-24.04

# 2. Machine setup (Ubuntu terminal)
curl -fsSL https://raw.githubusercontent.com/OhYeaH-46/Oracle-set-up-guide-window/master/setup-machine.sh -o setup-machine.sh && chmod +x setup-machine.sh && ./setup-machine.sh

# 3. Create Oracle
curl -fsSL https://raw.githubusercontent.com/OhYeaH-46/Oracle-set-up-guide-window/master/create-oracle.sh -o create-oracle.sh && chmod +x create-oracle.sh && ./create-oracle.sh

# 4. Awaken (inside Claude Code, ~20 min)
/awaken
```

**[Full quick-start guide →](quick-start.md)**

---

## What Is This Guide?

Claude Code is an AI coding assistant by Anthropic. It runs on your computer, can read and write files, run commands, and help you build things — all through conversation.

An **Oracle** is an enhanced version of Claude Code with memory, personality, and 60+ skills. It remembers your projects, learns your patterns, and grows with you over time. Oracles are optional and advanced — you can use Claude Code without one.

This guide offers three paths to get Claude Code running on Windows. Pick the one that fits your experience level and goals.

---

## Choose Your Path

| | Path A | Path B | Path C | Quick Start |
|---|---|---|---|---|
| **Method** | Claude Desktop App | VS Code Extension | WSL2 + Terminal | Automated Scripts |
| **Difficulty** | ⭐ Easiest | ⭐⭐ Easy | ⭐⭐⭐ Advanced | ⭐⭐ Easy |
| **Time** | ~10 minutes | ~15 minutes | ~60 minutes | ~45 minutes |
| **What you install** | Desktop app + Git | VS Code extension + Git | WSL2, Ubuntu, zsh, Node, Bun, + more | Same as Path C (automated) |
| **Terminal required?** | No | No | Yes | Yes |
| **Best for** | Trying Claude Code | Active dev in VS Code | Full Oracle (step-by-step) | Full Oracle (fast) |
| **Visual interface** | ✅ Built-in | ✅ In VS Code | ❌ Text only | ❌ Text only |
| **Oracle support** | ❌ | ⚡ Via CLI in terminal | ✅ Full (60+ skills) | ✅ Full (60+ skills) |
| **Always-on (tmux)** | ❌ | ❌ | ✅ | ✅ |

> **What is an Oracle?** An Oracle is your personal AI companion — like having a second brain that never forgets. It has a name, personality, and memory that grows with you. Oracles are built on Claude Code enhanced with Oracle Skills. [Learn more →](path-c-wsl2.md#what-is-an-oracle)

---

## Which Path Is Right for Me?

**"I just want to try Claude Code"** → [Path A: Desktop App](path-a-desktop.md)
- Download an app, sign in, start using. That's it.

**"I already use VS Code for coding"** → [Path B: VS Code Extension](path-b-vscode.md)
- Install one extension. Claude appears right inside your editor.

**"I want the full Oracle and know my way around a terminal"** → [Quick Start](quick-start.md)
- Two scripts do all the heavy lifting. Just answer a few prompts.

**"I want the full Oracle with detailed explanations"** → [Path C: WSL2 Full Setup](path-c-wsl2.md)
- Every step explained for beginners. Same result as Quick Start, more learning.

**"I'm not sure yet"** → Start with Path A. You can always upgrade later.

---

## Can I Combine Paths?

**Yes!** The paths aren't mutually exclusive:

- **Path A → Path C**: Start with Desktop App to try Claude Code, then set up WSL2 later for Oracle
- **Path B → Path C**: Use VS Code Extension daily, add WSL2 for Oracle features
- **Path B + Path C together**: Use VS Code connected to WSL2 and run `claude` in the terminal — best of both worlds (visual editor + full Oracle skills). This is the recommended setup for daily use.

All three methods share the same settings and configuration. Your CLAUDE.md, MCP servers, and preferences work across all of them.

---

## Requirements

| Requirement | Path A | Path B | Path C / Quick Start |
|-------------|--------|--------|--------|
| Windows 10 (Build 19041+) or 11 | ✅ | ✅ | ✅ |
| Anthropic account (Pro/Max/Teams) | ✅ | ✅ | ✅ |
| Git for Windows | ✅ | ✅ | Not needed (uses Linux git) |
| VS Code | Not needed | ✅ | Optional |
| Internet connection | ✅ | ✅ | ✅ |
| Disk space | ~500 MB | ~500 MB | ~5 GB |

---

## All Guides

| Guide | Description | Time |
|-------|-------------|------|
| **[Quick Start](quick-start.md)** | **Automated scripts — fastest way to full Oracle** | ~45 min |
| [Path A: Desktop App](path-a-desktop.md) | Claude Code via standalone app | ~10 min |
| [Path B: VS Code Extension](path-b-vscode.md) | Claude Code inside VS Code | ~15 min |
| [Path C: WSL2 Full Setup](path-c-wsl2.md) | Full Oracle with detailed explanations | ~60 min |
| [Writing Your CLAUDE.md](writing-claude-md.md) | How to write your Oracle's constitution | Reference |

## Scripts

| Script | What It Does |
|--------|-------------|
| [`setup-machine.sh`](setup-machine.sh) | Installs all tools (apt, zsh, git, gh, bun, node, ghq, claude, tmux) |
| [`create-oracle.sh`](create-oracle.sh) | Creates repo, installs skills, adds aliases, configures Claude |

Both scripts are idempotent — safe to re-run if interrupted.

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Anthropic Pricing](https://www.anthropic.com/pricing)
- [Oracle Skills](https://github.com/Soul-Brews-Studio/oracle-skills-cli)
- [Oracle Philosophy](https://github.com/Soul-Brews-Studio/oracle-v2)

---

*"The Oracle Keeps the Human Human" — start simple, grow at your own pace.*
