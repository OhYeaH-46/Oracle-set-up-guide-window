# Chapter 7: File Storage Guide

When you work with Oracle, files end up in several different places on your computer. Some belong to Claude Code itself. Some belong to your project. Some are Oracle's personal memory. This chapter explains where everything lives, why it lives there, and what you should (and should not) put in git.

---

## Understanding the File System

Your computer organizes everything into folders, like a giant filing cabinet. At the very top of your personal section of that cabinet is your **home directory** — a folder that belongs entirely to you.

Depending on your operating system, it lives here:

| Operating System | Your Home Directory |
|-----------------|---------------------|
| Mac | `/Users/yourname/` |
| Linux | `/home/yourname/` |
| Windows (inside WSL) | `/home/yourname/` |

When you see `~` in a file path, that's shorthand for your home directory. So `~/.claude/` means "the `.claude` folder inside your home directory."

Windows users have one extra layer to understand, which the last section of this chapter covers.

---

## Claude Code Configuration Files

Claude Code stores its own settings in a hidden folder inside your home directory. These files are **local only** — they stay on your machine and never get uploaded anywhere.

| Path | Purpose |
|------|---------|
| `~/.claude/` | Main Claude Code configuration directory |
| `~/.claude/settings.json` | Global settings: MCP servers, permissions, preferences |
| `~/.claude/skills/` | User-level skills — available in every project you open |
| `~/.claude/projects/` | Session data, stored separately per project |

Think of `~/.claude/` as your personal Claude Code workspace. No matter which project you open, Claude Code reads this folder first.

Because this folder is not inside any git repository, it does not back up automatically. See the Backup section at the end of this chapter.

---

## Project-Level Configuration

Each project has its own configuration that lives inside the project folder itself. Unlike the global settings above, these files can be committed to git and shared with your team.

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Oracle's personality, instructions, and project context |
| `.claude/` | Project-specific Claude Code configuration |
| `.claude/settings.json` | Project-specific settings (overrides global settings) |
| `.claude/skills/` | Project-specific skills — only available in this project |

`CLAUDE.md` is the most important file here. It is the first thing Oracle reads when a session starts. It defines who Oracle is, how she should behave, and what she knows about the project. Think of it as the briefing document Oracle reads every morning before starting work.

---

## Oracle Memory Files (the ψ Directory)

If you are using the full Oracle framework, your project will contain a `ψ/` directory. The `ψ` symbol is the Greek letter "psi" — you can simply say "the psi folder" or "the memory folder." This is Oracle's brain on disk.

**Inbox files** — things that change day to day:

| Path | Purpose |
|------|---------|
| `ψ/inbox/focus.md` | Today's priority and session goal |
| `ψ/inbox/projects.md` | Task tracking, organized by customer |
| `ψ/inbox/schedule.md` | Appointments and calendar items |
| `ψ/inbox/.checkpoint.md` | Session save state — written before compacting context |

**Memory files** — things Oracle accumulates over time:

| Path | Purpose |
|------|---------|
| `ψ/memory/learnings/` | Stored knowledge, one file per topic (timestamped) |
| `ψ/memory/resonance/` | Identity and personality files — Oracle's "soul" |
| `ψ/memory/logs/` | Daily logs and emotional notes |
| `ψ/memory/retrospectives/` | Session summaries, one file per session |

All of these files are committed to git. They form Oracle's permanent memory — every insight learned, every session completed, every project tracked. When you push to git, you are backing up Oracle's mind.

---

## Windows-Specific Notes (WSL)

Windows does not natively run the Linux tools that Claude Code depends on. The solution is **WSL** — Windows Subsystem for Linux — which is simply a way to run a full Linux environment inside Windows. Claude Code works best when run from inside WSL.

A few things to know if you are on Windows:

Your project files inside WSL live at `/home/yourname/` — the same path as regular Linux.

To see your WSL files from Windows Explorer, navigate to `\\wsl$\Ubuntu\home\yourname\` in the address bar.

To access your Windows files from inside WSL, they are available at `/mnt/c/Users/yourname/`.

Keep your projects inside WSL (not on `/mnt/c/`). Working across the WSL boundary is significantly slower and can cause unexpected file permission issues.

---

## What's Local-Only vs. What Goes in Git

This is the most important thing to get right. Some files belong in git (backed up, shareable). Others must never leave your computer.

| What | Local Only | In Git |
|------|-----------|--------|
| `~/.claude/settings.json` | Yes | No |
| `~/.claude/skills/` | Yes | No |
| `CLAUDE.md` | — | Yes |
| `.claude/settings.json` | — | Yes (if committed) |
| `.claude/skills/` | — | Yes (if committed) |
| `ψ/` directory | — | Yes |
| API keys and passwords | Yes | **Never — not ever** |

API keys are the credentials that let Claude Code talk to AI services. If an API key ends up in a public git repository, anyone on the internet can use it — running up charges on your account. This is not a theoretical risk; it happens frequently to people who are not careful. Never put an API key or any password in a file that is tracked by git.

---

## Backup Strategy

Git is your primary backup for everything inside your project folder. Push regularly.

For `~/.claude/`, you need to back it up manually — it is not inside any git repository. At minimum, copy `~/.claude/settings.json` somewhere safe. This file contains your MCP server configuration, and rebuilding it from scratch takes time.

A simple approach: periodically copy `~/.claude/` to a secure personal backup location (external drive, encrypted cloud folder). Do not push it to a public git repository, since it may contain server addresses or other private configuration.

---

## Key Takeaway

There are three layers of files to understand: Claude Code's global config in `~/.claude/` (local only, back up manually), your project config in `CLAUDE.md` and `.claude/` (commit to git and share freely), and Oracle's memory in `ψ/` (commit to git — this is her permanent brain). The one rule that overrides everything else: API keys and secrets never go in git, under any circumstances.

---

[← Previous: Memory and Context](06-memory-and-context.md) | [Next: Advanced Setup →](08-advanced-setup.md)
