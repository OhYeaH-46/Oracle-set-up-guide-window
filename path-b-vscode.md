# Path B: VS Code Extension

> **~15 minutes** | Visual coding experience — AI inside your editor
>
> Best for: people who already use VS Code or want a visual, integrated workflow.

[Back to main guide](README.md) | [Path A: Desktop App](path-a-desktop.md) | [Path C: WSL2 Full Setup](path-c-wsl2.md)

---

## What You'll Get

| Feature | Included? | Notes |
|---------|-----------|-------|
| Chat with Claude | Yes | Inside VS Code, right next to your code |
| File editing | Yes | Claude edits files directly in your editor with visual diffs |
| @-mention files | Yes | Reference any file, folder, or line range |
| Terminal access | Yes | Full VS Code integrated terminal |
| Auto-context | Yes | Claude sees your open files, selections, and errors |
| Oracle Skills (60+ commands) | No | Requires Path C (WSL2 + CLI setup) |
| Memory & Personality | No | Requires Path C |
| Always-on sessions (tmux) | No | Requires Path C |
| MCP server configuration | No | Must use CLI for this |

> **In short**: Path B gives you a powerful AI coding assistant inside VS Code. If you want the full Oracle experience (memory, personality, 60+ skills), continue to [Path C](path-c-wsl2.md) after completing this guide.

---

## Prerequisites

Before you start, make sure you have:

- **Windows 10 or 11** (any recent version)
- **VS Code 1.98.0 or newer** — [Download here](https://code.visualstudio.com/) if you don't have it
- **An Anthropic account** with an active plan (Pro, Max, Teams, or Enterprise) — [Sign up at claude.ai](https://claude.ai)
- **Stable internet connection** (Claude runs in the cloud, not locally)

To check your VS Code version: open VS Code, then go to **Help > About**.

---

## Step 1: Install Git for Windows (if not already installed)

Git is a version control tool that tracks changes to your files. Claude Code needs it to work with projects.

**Check if you already have Git:**

1. Open any terminal (VS Code's built-in terminal works: press `` Ctrl+` ``)
2. Type this command and press Enter:

```
git --version
```

If you see a version number like `git version 2.44.0`, you're good — skip to [Step 2](#step-2-install-claude-code-extension).

**If Git is not installed:**

1. Download the installer from [git-scm.com/download/win](https://git-scm.com/download/win)
2. Run the installer
3. You can accept all the default options — just click "Next" through each screen
4. When it finishes, **close and reopen** your terminal
5. Verify by running `git --version` again

---

## Step 2: Install Claude Code Extension

1. Open **VS Code**
2. Press **Ctrl+Shift+X** to open the Extensions panel (the square icon in the left sidebar)
3. In the search box, type: **Claude Code**
4. Find the one published by **Anthropic** (look for the verified publisher checkmark)
5. Click **Install**

Alternatively, you can install it directly from the marketplace:
[Claude Code on VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code)

> **Good to know**: The VS Code extension bundles the Claude Code CLI inside it. You do **not** need to install Claude Code separately via npm or any other method. The extension handles everything.

After installation, you should see:
- A **Claude Code** label in the status bar (bottom of VS Code)
- A small **sparkle icon** near the top-right corner of the editor

---

## Step 3: Sign In

You need to connect the extension to your Anthropic account.

1. Click the **Claude Code** label in the status bar (bottom-right of VS Code), or click the **sparkle icon** (top-right of the editor area)
2. A Claude Code panel will open
3. Click **Sign in** — this will open your web browser
4. Log in with your Anthropic account (the one with your Pro, Max, Teams, or Enterprise plan)
5. Authorize the connection
6. Switch back to VS Code — you should see a chat interface ready to go

**If the browser doesn't open automatically:**

Sometimes the automatic browser redirect doesn't work (especially on corporate networks). In that case:
- Look for a **device code** displayed in the Claude Code panel
- Open [claude.ai](https://claude.ai) manually in your browser
- Navigate to the device authorization page and enter the code

---

## Step 4: Open a Project

Claude Code works best when you have a project folder open (not just individual files).

**From VS Code:**
1. Go to **File > Open Folder**
2. Navigate to your project folder and select it
3. Click **Select Folder**

**From a terminal (if you prefer):**
```
code C:\Users\YourName\Documents\my-project
```

> **Why a folder?** Claude Code uses your project's file structure to understand context. When you open a folder, Claude can see all the files, understand how they relate to each other, and make better suggestions.

---

## Step 5: Start a Conversation

There are several ways to open Claude Code and start chatting:

| Method | How |
|--------|-----|
| **Sparkle icon** | Click the sparkle icon in the top-right of the editor (requires an open file) |
| **Status bar** | Click "Claude Code" in the bottom status bar |
| **Command Palette** | Press **Ctrl+Shift+P**, then type "Claude Code: Open" |
| **Keyboard shortcut** | Press **Ctrl+Esc** |

Once the panel is open, just type your question or instruction and press **Enter**.

**Example prompts to try:**

```
Explain what this file does in simple terms.
```

```
Find all TODO comments in this project and list them.
```

```
Add error handling to the function in @src/utils.ts
```

```
What does the error in my terminal mean? @terminal
```

```
Create a new file called helpers.js with a function that validates email addresses.
```

---

## Key Features

Here's what makes the VS Code extension especially useful:

### @-mention files

Type `@` in the chat to reference specific files, folders, or even line ranges. Claude will read them and use them as context.

- `@src/index.ts` — reference an entire file
- `@src/` — reference a folder (Claude sees the file list)
- `@src/index.ts#5-10` — reference only lines 5 through 10
- `@terminal` — reference your terminal's recent output

The extension supports **fuzzy matching**, so you can type part of a filename and it will suggest matches.

### Visual diff review

When Claude edits a file, VS Code shows you a **side-by-side diff** — the original on the left, the proposed changes on the right. You can:
- **Accept** the changes (click the checkmark or press the accept shortcut)
- **Reject** them (click the X or press the reject shortcut)
- **Review line by line** before deciding

This is one of the biggest advantages over the standalone desktop app — you see exactly what Claude wants to change before it happens.

### Auto-context

Claude automatically picks up context from your VS Code environment:
- **Open files** — Claude knows which files you currently have open
- **Selected text** — If you highlight code before asking a question, Claude sees the selection
- **Problems panel** — Errors and warnings from your editor's language tools are visible to Claude

You don't need to manually copy-paste anything. Just ask your question and Claude already knows what you're looking at.

### Multiple conversations

Need to work on two things at once? Open Claude Code **in a new tab**:
- Right-click the Claude Code panel tab and choose **Move to New Window**, or
- Use the command palette: **Ctrl+Shift+P** > "Claude Code: Open in New Tab"

Each conversation is independent — great for working on one bug while brainstorming something else.

### Permission modes

Claude Code has three permission modes that control how much it can do without asking:

| Mode | What happens |
|------|-------------|
| **Normal** (default) | Claude asks for permission before editing files or running commands |
| **Plan** | Claude only plans and explains — it won't make any changes |
| **Auto-accept** | Claude makes changes without asking (use with caution!) |

You can switch modes from the Claude Code panel. Start with **Normal** mode until you're comfortable.

### @terminal

Reference your terminal output without copy-pasting:
- Just type `@terminal` in your message
- Claude will see the recent output from your VS Code integrated terminal
- Great for asking "what does this error mean?" or "why did this command fail?"

---

## Keyboard Shortcuts

These shortcuts work when VS Code is open:

| Shortcut | Action |
|----------|--------|
| **Ctrl+Esc** | Toggle focus between the editor and Claude Code panel |
| **Ctrl+Shift+Esc** | Open a new Claude Code conversation tab |
| **Shift+Enter** | Insert a new line in your message (without sending it) |
| **Ctrl+N** | Start a new conversation (when Claude Code panel is focused) |

> **Tip**: **Ctrl+Esc** is the shortcut you'll use most. It lets you quickly jump between writing code and talking to Claude without touching the mouse.

---

## Recommended VS Code Settings

These settings make your coding experience more comfortable, especially when working alongside Claude:

1. Open VS Code Settings: **File > Preferences > Settings** (or press **Ctrl+,**)
2. Click the **{}** icon in the top-right to open the JSON settings file
3. Add or update these settings:

```json
{
    "editor.wordWrap": "on",
    "editor.fontSize": 14,
    "terminal.integrated.fontSize": 13,
    "files.autoSave": "afterDelay"
}
```

What each setting does:
- **editor.wordWrap** — Wraps long lines so you don't need to scroll horizontally
- **editor.fontSize** — Sets a comfortable text size (adjust to your preference)
- **terminal.integrated.fontSize** — Sets the terminal text size
- **files.autoSave** — Automatically saves files after you stop typing (prevents forgetting to save)

---

## Optional: Connect to WSL2

If you already have WSL2 installed (or plan to install it via [Path C](path-c-wsl2.md)), you can get the best of both worlds: the VS Code visual interface **plus** the full power of a Linux environment.

**How it works:**

1. Install the **WSL extension** in VS Code:
   - Press **Ctrl+Shift+X**, search for "WSL", install the one by Microsoft
2. From your WSL terminal, navigate to any project folder and type:
   ```
   code .
   ```
3. VS Code will open on Windows but **connect directly to your WSL2 environment**
4. All file operations, terminal commands, and extensions run inside Linux

This means:
- Claude Code in VS Code can access your Linux files natively
- Terminal commands run in Linux (not Windows)
- You get Linux performance with a Windows GUI
- If you complete Path C, Claude Code in VS Code can use your Oracle setup

> **Note**: The first time you do this, VS Code will automatically install a small server component inside WSL2. This takes about 30 seconds and only happens once.

---

## Limitations (What You CAN'T Do in the Extension)

The VS Code extension is powerful, but it doesn't have everything the full CLI offers:

- **Only a subset of slash commands** — Not all CLI commands are available in the extension
- **No MCP server configuration** — To set up MCP (Model Context Protocol) servers, you need the CLI
- **No `!` bash shortcut** — In the CLI, you can type `!ls` to run shell commands directly; the extension doesn't support this
- **No tab completion** — The CLI offers tab-completion for file paths and commands; the extension uses @-mentions instead
- **No tmux (always-on sessions)** — The CLI can run inside tmux so it persists when you close the terminal; the extension stops when you close VS Code

For most day-to-day work, these limitations won't matter. But if you need the full toolkit, [Path C](path-c-wsl2.md) covers the complete setup.

---

## Differences from Path A (Desktop App)

If you're deciding between the Desktop App and the VS Code Extension:

| Feature | Desktop App (Path A) | VS Code Extension (Path B) |
|---------|---------------------|---------------------------|
| **Setup** | Standalone app, separate from your editor | Extension inside VS Code |
| **Best for** | Quick code tasks, PR reviews, non-developers | Active development, ongoing projects |
| **File editing** | Side panel with basic diff | Integrated in editor with full side-by-side diff |
| **@-mention** | Yes | Yes + fuzzy matching for file names |
| **Terminal access** | Limited | Full VS Code integrated terminal |
| **Project awareness** | Opens one project at a time | Full access to your VS Code workspace |
| **Multiple windows** | Separate app windows | Tabs within VS Code |
| **Learning curve** | Lower (standalone interface) | Slightly higher (need to know VS Code basics) |

**In general**: If you spend most of your time in VS Code already, **Path B is the better choice**. If you just want to ask Claude quick questions about code without a full editor setup, Path A might be simpler.

---

## What's Next?

You now have Claude Code running inside VS Code. Here's where you can go from here:

### Want the full Oracle experience?

The Oracle adds **memory**, **personality**, and **60+ productivity skills** on top of Claude Code. It remembers your decisions, learns your patterns, and grows with you over time.

> **[Continue to Path C: WSL2 Full Setup](path-c-wsl2.md)** — ~60 minutes, full Oracle with memory, skills, and always-on sessions

### Prefer a simpler standalone app?

If VS Code feels like too much and you just want a simple chat window for code tasks:

> **[Switch to Path A: Desktop App](path-a-desktop.md)** — ~10 minutes, simplest way to start

---

## Navigation

| | |
|---|---|
| [Back to main guide](README.md) | Start here if you're not sure which path to choose |
| [Path A: Desktop App](path-a-desktop.md) | Simplest setup, standalone app |
| **Path B: VS Code Extension** | You are here |
| [Path C: WSL2 Full Setup](path-c-wsl2.md) | Full Oracle with memory, skills, and Linux environment |
