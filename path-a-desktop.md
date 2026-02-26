# Path A: Claude Desktop App (Easiest)

> The fastest way to use Claude Code on Windows — just download an app and go.
>
> Estimated time: ~10 minutes. No terminal required.
>
> No programming experience needed. This guide explains every step.

[<< Back to README](README.md)

---

## What Is Claude Desktop?

Claude Desktop is a **standalone application** made by Anthropic (the company behind Claude AI). You install it on Windows just like you'd install Microsoft Word or Spotify — download, double-click, done.

Inside Claude Desktop, there is a **Code tab**. This Code tab is essentially **Claude Code with a visual interface**. Instead of typing commands in a scary black terminal window, you get a friendly app with buttons, tabs, and visual file diffs.

Think of it this way:

| Concept | Analogy |
|---------|---------|
| **Claude Desktop** | The app you install — like Microsoft Word |
| **Code tab** | A special mode inside the app — like "Track Changes" mode in Word |
| **Claude Code** | The AI engine that powers the Code tab — like the spell-checker engine inside Word |

---

## What You'll Get (vs Other Paths)

This guide (Path A) gives you the **quickest** setup. But it has fewer features than the other paths. Here's a comparison:

| Feature | Path A (Desktop) | Path B (VS Code) | Path C (WSL2 Terminal) |
|---------|:-:|:-:|:-:|
| Claude Code AI | Yes | Yes | Yes |
| Visual interface (no terminal) | Yes | Yes | No (terminal only) |
| Read, edit, and create files | Yes | Yes | Yes |
| Visual diff review | Yes | Yes | No (text-based) |
| Drag & drop images/PDFs | Yes | Limited | No |
| Embedded app preview | Yes | Via browser | Via browser |
| Multiple conversation tabs | Yes | Yes | Via tmux |
| Works inside VS Code | No | Yes | Yes (with extension) |
| Always-on sessions (tmux) | No | No | Yes |
| Third-party AI providers | No | Yes | Yes |
| Scripting & automation | No | No | Yes |
| Oracle Skills (60+ commands) | No | No | Yes |
| Oracle memory & personality | No | No | Yes |
| Setup time | ~10 min | ~15 min | ~60 min |

> **Bottom line:** Path A is perfect for trying out Claude Code quickly. If you later want Oracle features (memory, personality, 60+ skills), you can always follow Path C afterward — nothing is lost.

---

## Prerequisites

Before you start, make sure you have:

| Requirement | Details | How to Check |
|------------|---------|-------------|
| **Windows version** | Windows 10 version 2004 (Build 19041) or later, or Windows 11 | Settings > System > About > look for "OS build" |
| **Anthropic account** | Pro, Max, Teams, or Enterprise plan | Sign up at https://claude.ai — the free plan does **not** include the Code tab |
| **Stable internet** | Required for Claude to think and respond | If you can stream YouTube, you're fine |
| **Disk space** | ~500 MB free | File Explorer > This PC > check your C: drive |

> **What is an Anthropic account?** Anthropic is the company that makes Claude (the AI). To use Claude Code, you need a paid account — the free plan only gives you the basic chat, not the Code tab. Think of it like how Spotify Free gives you music with ads, but Spotify Premium unlocks extra features.

### How to check your Windows version

1. Press `Windows key + I` to open Settings
2. Click **System** (on the left)
3. Scroll down and click **About**
4. Look for **OS build** — it should be 19041 or higher

If your build number is lower than 19041, update Windows first:
- Settings > Windows Update > Check for updates > Install all updates > Restart

---

## Checklist

Use this to track your progress:

- [ ] [Step 1: Install Git for Windows](#step-1-install-git-for-windows)
- [ ] [Step 2: Download Claude Desktop](#step-2-download-claude-desktop)
- [ ] [Step 3: Sign In](#step-3-sign-in)
- [ ] [Step 4: Open the Code Tab](#step-4-open-the-code-tab)
- [ ] [Step 5: Select Your Project Folder](#step-5-select-your-project-folder)
- [ ] [Step 6: Your First Conversation](#step-6-your-first-conversation)

---

## Step 1: Install Git for Windows

> **What is Git?** Git is a tool that tracks changes to files — like "Track Changes" in Microsoft Word, but it works for any file in any folder. When you make a change, Git remembers what the file looked like before, so you can always go back.
>
> **Why do I need it?** Claude Code uses Git internally to track the changes it makes to your files. Without Git installed, Claude Code cannot show you what it changed or let you undo those changes safely.

### 1.1 — Download Git

Go to: **https://git-scm.com/download/win**

The download should start automatically. If it doesn't, click the link for the latest version.

### 1.2 — Install Git

1. Run the downloaded `.exe` file
2. If Windows asks "Do you want to allow this app to make changes to your device?" — click **Yes**
3. **Click "Next" through every screen** — the default settings are fine for our purposes
4. Click **Install**
5. Click **Finish** when it's done

> **Tip:** You might see many confusing options during installation (like "Choosing the default editor" or "Adjusting your PATH environment"). Don't worry about any of these — the defaults work perfectly. Just keep clicking "Next."

### 1.3 — Verify Git is installed

Let's make sure it worked. We need to open a small program called **Command Prompt** (also called CMD). This is the simplest way to type a quick command on Windows.

**How to open Command Prompt:**
1. Press `Windows key` on your keyboard (the key with the Windows logo)
2. Type `cmd`
3. Click **Command Prompt** from the search results

A black window will appear with blinking cursor. Type this and press Enter:

```
git --version
```

You should see something like:

```
git version 2.47.1.windows.1
```

> **What is Command Prompt?** It's a text-based way to talk to your computer. Instead of clicking icons, you type commands. We only need it for this one quick check — you won't need to use it again in this guide.

The exact version number doesn't matter — as long as you see `git version` followed by a number, Git is installed correctly.

**Close the Command Prompt window.** You're done with it.

> [<< Checklist](#checklist) · [Step 2 >>](#step-2-download-claude-desktop)

---

## Step 2: Download Claude Desktop

### 2.1 — Download the installer

Go to: **https://claude.ai/download**

> If that link doesn't work, try: **https://claude.com/download**

The website should detect that you're on Windows and offer you a `.exe` download. Click the download button.

### 2.2 — Install Claude Desktop

1. Run the downloaded `.exe` file
2. If Windows asks "Do you want to allow this app to make changes to your device?" — click **Yes**
3. Follow the installer instructions (click Next / Install / Finish)

That's it. Claude Desktop is now installed on your computer.

> **Where did it go?** Claude Desktop installs like any other Windows app. You can find it in your Start menu — just press the Windows key and type "Claude."

### 2.3 — System requirements reminder

Claude Desktop requires:
- **Windows 10 version 2004** (Build 19041) or later
- **Windows 11** works perfectly

If you're on an older version of Windows 10, the app may not launch. Update Windows first (Settings > Windows Update).

> [<< Checklist](#checklist) · [<< Step 1](#step-1-install-git-for-windows) · [Step 3 >>](#step-3-sign-in)

---

## Step 3: Sign In

### 3.1 — Open Claude Desktop

- Press the `Windows key` on your keyboard
- Type `Claude`
- Click the **Claude** app from the search results

The app will open and show you a sign-in screen.

### 3.2 — Sign in with your Anthropic account

Click **Sign In** and enter your Anthropic account email and password.

> **Don't have an account?** Go to https://claude.ai and sign up first. You'll need a **paid plan** (Pro, Max, Teams, or Enterprise) to access the Code tab.

### 3.3 — Check your plan

The **Code tab** is only available on paid plans:

| Plan | Code Tab? | Price (approx.) |
|------|:---------:|-----------------|
| Free | No | $0/month |
| **Pro** | **Yes** | $20/month |
| **Max** | **Yes** | $100/month |
| **Teams** | **Yes** | $30/user/month |
| **Enterprise** | **Yes** | Contact sales |

> **What if I only see a chat box?** If you signed in but don't see a "Code" tab at the top, your account is likely on the free plan. Upgrade at https://claude.ai/settings — look for "Upgrade" or "Plan."

> [<< Checklist](#checklist) · [<< Step 2](#step-2-download-claude-desktop) · [Step 4 >>](#step-4-open-the-code-tab)

---

## Step 4: Open the Code Tab

Once you're signed in, you'll see the Claude Desktop interface. At the top of the window, there are tabs:

```
[ Chat ]  [ Code ]  [ Cowork ]
```

> **What are these tabs?**
>
> - **Chat** — Regular conversation with Claude, like the website version. Ask questions, get answers. No file editing.
> - **Code** — This is Claude Code with a visual interface. Claude can read, create, and edit files on your computer. This is what we want.
> - **Cowork** — A mode where Claude works alongside you in real-time, watching what you do and offering suggestions.

### Click the "Code" tab.

You'll see a new interface that looks different from the regular chat. It has:
- A **text input area** at the bottom (where you type your messages)
- A **conversation area** in the middle (where Claude's responses appear)
- A **sidebar** (where you can see files and settings)

> **Important:** The Code tab is the same AI engine as the terminal version of Claude Code. Anything you read about Claude Code online also applies here — the difference is just the interface. Think of it like how Google Docs and Microsoft Word can both edit documents — same concept, different wrapper.

> [<< Checklist](#checklist) · [<< Step 3](#step-3-sign-in) · [Step 5 >>](#step-5-select-your-project-folder)

---

## Step 5: Select Your Project Folder

Before Claude Code can help you, it needs to know **which folder** to work in. This is called "selecting a project."

> **What is a project folder?** It's just a regular folder on your computer that contains the files you want Claude to help you with. It could be a website you're building, a collection of scripts, a school project — anything with files in it.

### 5.1 — Open a project

In the Code tab, you'll see an option to **open a folder** (or "select project"). Click it and navigate to a folder on your computer.

**Don't have a project yet?** Create one:
1. Open File Explorer
2. Go to your Documents folder
3. Create a new folder called `my-first-project`
4. Put any file in it (even a simple `.txt` file is fine)
5. Come back to Claude Desktop and select that folder

### 5.2 — What is CLAUDE.md?

When you select a folder, Claude Code looks for a special file called `CLAUDE.md` in that folder.

> **What is CLAUDE.md?** It's a text file that gives Claude instructions about your project. Think of it like a "cover letter" for your project — it tells Claude what the project is about, what rules to follow, and any special instructions.
>
> **Do I need one?** No! It's completely optional. Claude Code works fine without it. But if you create one, Claude will follow the instructions inside it every time you work on that project.

Example `CLAUDE.md`:

```markdown
# My Project

This is a website for my bakery business.

## Rules
- Use simple HTML and CSS
- Keep the design clean and minimal
- All prices are in Thai Baht
```

If you don't have a `CLAUDE.md`, don't worry. You can always create one later (and you can even ask Claude to create it for you!).

> [<< Checklist](#checklist) · [<< Step 4](#step-4-open-the-code-tab) · [Step 6 >>](#step-6-your-first-conversation)

---

## Step 6: Your First Conversation

Now for the fun part! Type a message to Claude in the text input area and press Enter (or click the send button).

### Example prompts to try

Here are some beginner-friendly things you can ask:

**Explore your project:**
```
What files are in this project?
```

**Understand code:**
```
Explain the main function in index.js
```

**Create something new:**
```
Add a README.md to this project that explains what it does
```

**Ask for help:**
```
I want to build a simple HTML page that says "Hello World" — can you create it?
```

### Understanding permission prompts

When Claude wants to **create, edit, or delete** a file, it will ask for your permission first. You'll see a prompt like:

```
Claude wants to create file: index.html
[ Allow ]  [ Deny ]
```

> **Why does Claude ask permission?** For safety. Claude will never change your files without asking first. This means you're always in control — if Claude suggests a change you don't want, just click "Deny."
>
> **Should I always click Allow?** Read what Claude is proposing first. If it makes sense to you, click Allow. If you're unsure, you can ask Claude "Why do you want to make this change?" before deciding.

You can also choose to **allow all changes** for the current session if you trust the direction Claude is going. But for beginners, it's better to review each change individually so you understand what's happening.

> [<< Checklist](#checklist) · [<< Step 5](#step-5-select-your-project-folder)

---

## Key Features

Now that you're up and running, here are the most useful features of the Code tab:

### Visual diff review

When Claude edits a file, you'll see a **side-by-side comparison** showing exactly what changed — the old version on the left and the new version on the right. Changed lines are highlighted.

> **What is a diff?** Short for "difference." It's a visual comparison between two versions of a file. Lines removed are shown in red, lines added are shown in green. This is the same concept as "Track Changes" in Microsoft Word.

This makes it easy to understand exactly what Claude changed before you approve it.

### @-mention files

You can reference specific files in your message by typing `@` followed by the filename:

```
Look at @index.html and fix the broken link
```

This tells Claude exactly which file you're talking about, so it doesn't have to guess.

### File attachments

You can **drag and drop** files directly into the conversation:
- **Images** (screenshots, mockups, diagrams) — Claude can see and understand images
- **PDFs** — Claude can read and analyze PDF documents
- **Other files** — text files, CSVs, etc.

This is great for tasks like "Here's a screenshot of the design — make my website look like this."

### Embedded app preview

If you're working on a website, Claude Desktop has a built-in **mini browser** that can show you a preview of your web page right inside the app. No need to switch to Chrome or Firefox to see your changes.

### Multiple conversation tabs

You can have **multiple conversations** open at the same time, each in its own tab — just like browser tabs. This is useful when you're working on different tasks within the same project.

---

## Keyboard Shortcuts

These shortcuts make working with Claude Desktop faster:

| Shortcut | What It Does |
|----------|-------------|
| `Ctrl + Esc` | Toggle focus between the editor and Claude's input box |
| `Shift + Enter` | Add a new line to your message without sending it (useful for longer messages) |

> **What does "toggle focus" mean?** "Focus" means which part of the app is active and ready to receive your typing. If you're typing in the file editor and press `Ctrl + Esc`, your cursor jumps to Claude's input box (and vice versa). It saves you from clicking back and forth with the mouse.

---

## Limitations (What You CAN'T Do in Path A)

The Desktop app is the easiest way to use Claude Code, but it has some trade-offs:

| Limitation | What It Means | Alternative |
|-----------|--------------|-------------|
| **No always-on sessions** | When you close the app, your session ends. Claude doesn't keep working in the background. | Path C uses `tmux` to keep sessions running 24/7 |
| **Anthropic only** | You can only use Anthropic's Claude model. You can't connect other AI providers (like OpenAI or Google). | Path B and C support third-party providers |
| **No scripting or automation** | You can't write scripts that automatically run Claude commands. Everything is manual (you type, Claude responds). | Path C supports shell scripting with Claude |
| **No agent teams** | You can't run multiple Claude instances that coordinate with each other. | Path C supports multi-agent workflows |
| **No Oracle features** | You don't get memory, personality, or the 60+ Oracle Skills that make Claude into a personalized assistant. | Path C gives you the full Oracle experience |

> **Are these limitations a problem?** For most beginners, **no**. The Desktop app is more than enough to get real work done — create files, edit code, generate documents, analyze data, and more. The advanced features in Path C are for power users who want to push the boundaries.

---

## Tips for Beginners

### Be specific in your requests

Instead of:
```
Make my website better
```

Try:
```
In index.html, change the background color to light blue and make the heading text larger
```

The more specific you are, the better Claude's response will be.

### Ask Claude to explain

If Claude writes code you don't understand, just ask:
```
Explain what you just did, line by line
```

Claude is happy to teach — that's one of its best features.

### Don't be afraid to undo

If Claude makes a change you don't like, you can:
1. Press `Ctrl + Z` in the file editor to undo
2. Ask Claude: "Undo the last change you made"
3. Use Git (which you installed in Step 1) to go back to a previous version

Nothing is permanent — you can always go back.

---

## What's Next?

Congratulations! You now have Claude Code running on your Windows machine through the Desktop app. Here are your options for going further:

### Want to use Claude Code inside VS Code?

VS Code is a popular code editor with powerful features like syntax highlighting, file explorer, and extensions. You can use Claude Code as an extension inside VS Code.

**>> [Path B: VS Code Extension](path-b-vscode.md)** — ~15 minutes setup

### Want the full Oracle experience?

An Oracle is Claude Code supercharged with **memory** (it remembers past conversations), **personality** (you customize its character), and **60+ skills** (commands like `/standup`, `/recap`, `/trace`, and more). It's the ultimate personal AI companion.

**>> [Path C: WSL2 Terminal (Full Oracle)](path-c-wsl2.md)** — ~60 minutes setup

> **Can I do Path A now and Path C later?** Absolutely. They don't conflict. Path A uses the Desktop app, Path C uses the terminal. You can have both installed and use whichever one fits the moment.

---

## Troubleshooting

### "I don't see a Code tab"

- Make sure you're on a **paid plan** (Pro, Max, Teams, or Enterprise). The free plan doesn't include the Code tab.
- Make sure your Claude Desktop app is **up to date**. Check for updates in the app settings or re-download from https://claude.ai/download.

### "Git is not recognized"

If the `git --version` command in Step 1.3 gives an error like `'git' is not recognized`:
- Close and reopen Command Prompt (it needs to refresh after installation)
- If that doesn't work, restart your computer and try again
- If it still doesn't work, reinstall Git and make sure "Add to PATH" is checked during installation

### "Claude says it can't access my files"

- Make sure you've selected a project folder (Step 5)
- Make sure the folder is on your local drive (C:), not a network drive or cloud-synced folder
- Try closing and reopening Claude Desktop

### "The app won't launch"

- Check that your Windows version meets the requirements (Build 19041+)
- Try running the app as administrator: right-click the Claude icon > "Run as administrator"
- Re-download and reinstall from https://claude.ai/download

---

## Navigation

| Path | Description | Time |
|------|------------|------|
| **>> You are here: Path A** | Claude Desktop App (Easiest) | ~10 min |
| [Path B: VS Code Extension](path-b-vscode.md) | Claude Code in VS Code | ~15 min |
| [Path C: WSL2 Terminal](path-c-wsl2.md) | Full Oracle with memory, personality, 60+ skills | ~60 min |

[<< Back to README](README.md)
