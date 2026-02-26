# Oracle Setup Guide — Windows

> Your AI companion on Windows — choose the setup that fits you best.
>
> No programming experience required. Each path explains every step.

---

## What Is This Guide?

Claude Code is an AI coding assistant by Anthropic. It runs on your computer, can read and write files, run commands, and help you build things — all through conversation.

An **Oracle** is an enhanced version of Claude Code with memory, personality, and 60+ skills. It remembers your projects, learns your patterns, and grows with you over time. Oracles are optional and advanced — you can use Claude Code without one.

This guide offers three paths to get Claude Code running on Windows. Pick the one that fits your experience level and goals.

---

## Choose Your Path

| | Path A | Path B | Path C |
|---|---|---|---|
| **Method** | Claude Desktop App | VS Code Extension | WSL2 + Terminal |
| **Difficulty** | ⭐ Easiest | ⭐⭐ Easy | ⭐⭐⭐ Advanced |
| **Time** | ~10 minutes | ~15 minutes | ~60 minutes |
| **What you install** | Desktop app + Git | VS Code extension + Git | WSL2, Ubuntu, zsh, Node, Bun, + more |
| **Terminal required?** | No | No | Yes |
| **Best for** | Trying Claude Code for the first time | Active development in VS Code | Full Oracle experience |
| **Visual interface** | ✅ Built-in | ✅ In VS Code | ❌ Text only |
| **Visual diff review** | ✅ | ✅ | ❌ |
| **@-mention files** | ✅ | ✅ | ❌ |
| **Oracle support** | ❌ | ❌ | ✅ Full (60+ skills) |
| **Always-on (tmux)** | ❌ | ❌ | ✅ |
| **Agent teams** | ❌ | ❌ | ✅ |

> **What is an Oracle?** An Oracle is your personal AI companion — like having a second brain that never forgets. It has a name, personality, and memory that grows with you. Oracles are built on Claude Code enhanced with Oracle Skills. [Learn more →](path-c-wsl2.md#what-is-an-oracle)

---

## Which Path Is Right for Me?

**"I just want to try Claude Code"** → [Path A: Desktop App](path-a-desktop.md)
- Download an app, sign in, start using. That's it.

**"I already use VS Code for coding"** → [Path B: VS Code Extension](path-b-vscode.md)
- Install one extension. Claude appears right inside your editor.

**"I want the full Oracle — memory, personality, skills"** → [Path C: WSL2 Full Setup](path-c-wsl2.md)
- The complete experience. Takes longer but unlocks everything.

**"I'm not sure yet"** → Start with Path A. You can always upgrade to Path B or C later.

---

## Can I Combine Paths?

**Yes!** The paths aren't mutually exclusive:

- **Path A → Path C**: Start with Desktop App to try Claude Code, then set up WSL2 later for Oracle
- **Path B → Path C**: Use VS Code Extension daily, add WSL2 for Oracle features
- **Path B + Path C together**: Use VS Code Extension connected to WSL2 — best of both worlds (visual editor + Oracle skills)

All three methods share the same settings and configuration. Your CLAUDE.md, MCP servers, and preferences work across all of them.

---

## Requirements

| Requirement | Path A | Path B | Path C |
|-------------|--------|--------|--------|
| Windows 10 (Build 19041+) or 11 | ✅ | ✅ | ✅ |
| Anthropic account (Pro/Max/Teams) | ✅ | ✅ | ✅ |
| Git for Windows | ✅ | ✅ | Not needed (uses Linux git) |
| VS Code | Not needed | ✅ | Optional |
| Internet connection | ✅ | ✅ | ✅ |
| Disk space | ~500 MB | ~500 MB | ~5 GB |

---

## Quick Links

- [Path A: Claude Desktop App](path-a-desktop.md) — Easiest, ~10 min
- [Path B: VS Code Extension](path-b-vscode.md) — Easy, ~15 min
- [Path C: WSL2 Full Setup](path-c-wsl2.md) — Advanced, ~60 min (includes Oracle)

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Anthropic Pricing](https://www.anthropic.com/pricing)
- [Oracle Skills](https://github.com/Soul-Brews-Studio/oracle-skills-cli)
- [Oracle Philosophy](https://github.com/Soul-Brews-Studio/oracle-v2)

---

*"The Oracle Keeps the Human Human" — start simple, grow at your own pace.*
