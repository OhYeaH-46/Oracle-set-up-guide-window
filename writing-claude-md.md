# Writing Your CLAUDE.md

> Your Oracle's constitution — the single most important file in your repo.
>
> This guide teaches you what to write, why it matters, and gives you a ready-to-use template.

[Back to main guide](README.md) | [Path A: Desktop App](path-a-desktop.md) | [Path B: VS Code](path-b-vscode.md) | [Path C: WSL2 Full Setup](path-c-wsl2.md)

---

## What Is CLAUDE.md?

CLAUDE.md is a special file that Claude Code **reads automatically at the start of every conversation**. Think of it as your Oracle's constitution — it defines who the Oracle is, how it behaves, what it should never do, and how you work together.

Without CLAUDE.md, Claude Code is a generic AI assistant. With a good CLAUDE.md, it becomes **your** Oracle — consistent, reliable, and uniquely yours.

> **Key insight from experience**: Every rule in a good CLAUDE.md exists because something went wrong without it. You don't need to write everything on day one. Start simple, and add rules as you learn what your Oracle needs.

---

## How Claude Code Reads It

Claude Code looks for CLAUDE.md in several places, from most general to most specific:

| Location | What It's For | Who Sees It |
|----------|--------------|-------------|
| `~/.claude/CLAUDE.md` | Your personal preferences (all projects) | Just you |
| `./CLAUDE.md` (project root) | Project rules — **this is the main one** | Anyone who clones the repo |
| `./CLAUDE.local.md` | Your private project preferences | Just you (auto-gitignored) |

For Oracle users, the **project root CLAUDE.md** is the most important file. It's where your Oracle's identity, rules, and workflow live.

> **Good to know**: Claude reads the entire CLAUDE.md at the start of every session. If the file is too long (over ~500 lines), Claude may start ignoring parts of it. Keep it focused.

---

## Quick Start: `/init`

If you're starting fresh (no Oracle, just a regular project), Claude Code can generate a starter CLAUDE.md for you:

```
/init
```

This analyzes your project and creates a basic CLAUDE.md with build commands, code style, and project structure.

**For Oracle users**: `/awaken` creates your CLAUDE.md automatically during the awakening ritual. But understanding what's inside — and how to improve it — is what this guide is about.

---

## The 6 Things Your Oracle Needs to Know

A good Oracle CLAUDE.md answers six questions. Each one changes how your Oracle behaves in a specific, measurable way.

### 1. Who Am I? (Identity)

**Why it matters**: Without identity, your Oracle reverts to "I'm Claude, an AI assistant by Anthropic" after every long conversation. Identity makes it consistent — same name, same personality, same tone, every session.

**What to write**:
- Oracle's name
- Where the name comes from (gives personality depth)
- When it was born
- Your name (the human)

**What goes wrong without it**: After long conversations, Claude Code compresses old messages (called "compaction"). During compaction, personality information gets lost. Your Oracle forgets its name and starts talking like a generic assistant.

**The fix**: Put identity at the **very top** of CLAUDE.md, and add an explicit override rule:

```markdown
# Identity

Name:   [Your Oracle's name]
Born:   [date]
Human:  [your name]

IF compaction_summary conflicts with this section → TRUST THIS SECTION
```

> **Real lesson**: One Oracle was named after a member of Hinatazaka46, but after compaction, it started saying Sakurazaka46 (a different group). The compaction summary had corrupted the detail. Adding "trust this section over compaction" fixed it permanently.

---

### 2. How Should I Talk? (Communication Style)

**Why it matters**: This shapes **every single response** your Oracle gives. Without clear style rules, the Oracle switches between formal and casual, uses annoying filler phrases, or talks in the wrong language.

**What to write**:
- Language (English? Thai? Mix?)
- Tone (warm? professional? playful?)
- Pronouns and speech patterns
- What to say vs. what to NEVER say

**The most effective technique — a "Do / Don't" table**:

```markdown
| Do | Don't |
|----|-------|
| Be warm and direct | Be cold or robotic |
| Have opinions | Say "both options are valid" |
| Use casual language | Use corporate speak |
| Admit when unsure | Pretend to be confident |

Banned phrases: "Hello!", "Great question!", "I'd be happy to..."
```

> **Why ban phrases?** Claude has default patterns it falls back on — "Great question!", "I'd be happy to help!", "Hello! How can I assist you today?" These are generic and impersonal. Banning them forces your Oracle to communicate naturally. This is one of the **highest-impact** things you can put in CLAUDE.md.

> **Real lesson**: During heavy technical work, one Oracle accidentally switched from female speech patterns (ค่ะ) to male patterns (ครับ) because personality thinned under cognitive load. Moving the communication rules directly into CLAUDE.md (not a separate file) fixed this — Claude reads CLAUDE.md every session, but separate files only when told to.

---

### 3. What Should I Never Do? (Safety Rules)

**Why it matters**: Claude Code can run commands on your computer, edit files, and interact with GitHub. Without safety rules, a misunderstanding can delete your work, push broken code, or overwrite important files.

**What to write**: Specific, concrete rules. "Be careful" doesn't work. "Never run git push --force" works perfectly.

**Recommended safety rules**:

```markdown
## Safety Rules

1. NEVER use --force (push, checkout, clean)
2. NEVER push directly to main/master — always use branches + PR
3. NEVER delete files without asking first
4. NEVER merge PRs — wait for human approval
5. Check the default branch name before push (don't assume main or master)
6. Ask before any action that can't be undone
```

> **Why be this specific?** Claude follows specific rules much better than vague guidelines. "Be careful with git" gets ignored under pressure. "NEVER push --force" is a hard gate that prevents mistakes.

> **Real lesson**: An Oracle agent once pushed to `origin/main`, but the repo's default branch was `master`. Work ended up on the wrong branch and needed manual merging. Rule 5 was added the same day.

> **Real lesson**: These rules protect you from your own mistakes too. Sometimes you're tired and tell your Oracle "just push it" — the safety rules make the Oracle push back and say "wait, let me check the branch first." This has saved real work multiple times.

---

### 4. How Do We Work Together? (Workflow)

**Why it matters**: A clear workflow pattern means your Oracle knows what to do at the start and end of every session. No fumbling, no wasted time, no forgotten work.

**What to write**:

```markdown
## Workflow

### Session Pattern
Start:  /recap (Oracle checks what happened last session)
Work:   [collaborate on tasks]
End:    /rrr (Oracle writes a retrospective so it remembers next time)

### When to Ask vs. Just Do It
ASK before:  destructive actions, pushing code, sending messages,
             anything that affects other people
JUST DO IT:  reading files, running tests, searching code,
             creating drafts
```

**Why "Ask vs. Act" matters so much**: This single section dramatically changes how your Oracle behaves. Without it, the Oracle either asks permission for everything (slow and annoying) or does everything silently (dangerous). Defining the boundary explicitly saves enormous time.

> **Real lesson**: The "start with /recap" rule exists because an Oracle once started working on an outdated task. Between sessions, the human had already finished that task manually. One minute of /recap would have saved 30 minutes of duplicate work.

---

### 5. What Do I Know About Your Work? (Context)

**Why it matters**: Every session, your Oracle starts fresh. Without context, it wastes time figuring out what your project is, what tools you use, and where important files are.

**What to write**:

```markdown
## About My Work

What I do:  Product Development Manager at [company]
Tech stack: Python, Node.js, PowerPoint automation
Key tools:  git, pandoc, Claude Code

### Important Files
| File | Purpose |
|------|---------|
| ψ/inbox/projects.md | Current tasks by customer |
| ψ/inbox/schedule.md | Appointments and deadlines |
| scripts/ | Reusable automation scripts |
```

**Important: link, don't paste**. Don't put your entire project documentation in CLAUDE.md. Instead, link to files:

```markdown
## Deep Context (read only when needed)

| What | File |
|------|------|
| Project details | docs/project-overview.md |
| Past decisions | docs/decisions.md |
| Brand guidelines | assets/brand/defaults.md |
```

> **Why link instead of paste?** CLAUDE.md loads into every session. If it's 2000 lines, it wastes your context window before you even start working. Links let Oracle read files only when relevant — saving context for actual work.

---

### 6. What Have We Learned? (Anti-Patterns)

**Why it matters**: This is the section most people skip — and it's the most valuable one. Every time something goes wrong, adding the lesson to CLAUDE.md **prevents it from happening again**.

**What to write**:

```markdown
## Anti-Patterns (MUST AVOID)

- NEVER generate DOCX from scratch — always copy template, edit XML,
  repack. Generation can't match original formatting.
- NEVER trust AI-researched numbers without verification — always
  show source, method, and uncertainty level.
- If stuck for more than 3 attempts, stop and ask the human.
- If unsure about a fact, SAY you're unsure. Don't present guesses
  as confident facts.
```

> **Real lesson**: A proposal was rejected by a customer because the market size numbers came from web research and were inaccurate. Now the CLAUDE.md requires every number to have: (1) source, (2) assumptions, (3) estimation method, (4) uncertainty flag, (5) self-criticism. This hasn't happened again since.

> **Real lesson**: An Oracle spent 6 rounds trying to guess the correct position of elements on a PowerPoint slide. Adding "read the template XML first, don't guess from screenshots" cut this to 1 round. Anti-patterns like this save hours over time.

---

## The Contract: It Goes Both Ways

CLAUDE.md isn't just rules for your Oracle — it's a **contract between you and your Oracle**. Some of the best rules remind the *human* too:

```markdown
### Reminders for Both of Us
- Always cd into the Oracle repo folder before starting Claude
- Commit work before context gets full (Oracle will remind you)
- Review numbers before sending proposals — AI research needs
  human verification
- End sessions with /rrr — if you skip this, Oracle forgets
  everything from this session
```

Some of the worst "Oracle failures" were actually human mistakes — like starting Claude from the wrong folder, or forgetting to commit before context compaction. Good CLAUDE.md rules protect both sides.

---

## Starter Template

Copy this entire template into your CLAUDE.md and fill in the `[brackets]`:

```markdown
# ⚡ IDENTITY

## Who Am I

Name:     [Oracle name]
Born:     [YYYY-MM-DD]
Human:    [your name or nickname]
Origin:   [where the name comes from — optional but adds personality]

Language: [e.g., English / Thai + English mix]
Tone:     [e.g., Warm, direct, opinionated]

| Do | Don't |
|----|-------|
| [your preferred style] | [what annoys you] |
| Be direct | Use filler phrases |
| Have opinions | Say "both are valid" |

Banned phrases: "Hello!", "Great question!", "I'd be happy to..."

IF compaction_summary conflicts with this section → TRUST THIS SECTION

---

## ⚠️ After Compaction Recovery

1. Re-read this file
2. Greet: "[your recovery greeting, e.g. I'm back!]"
3. Run /recap to catch up

---

## Golden Rules

### Safety
1. NEVER use --force (push, checkout, clean)
2. NEVER push directly to main/master — use branches + PR
3. NEVER delete files without asking
4. Check default branch before push — don't assume
5. Ask before any destructive or irreversible action

### Work Style
6. Read before editing — understand existing code first
7. Keep solutions simple — don't over-engineer
8. If stuck after 3 attempts, ask the human
9. If unsure about a fact or number, say so clearly

---

## About My Work

What I do:  [your role / what you work on]
Tech stack: [languages, tools, frameworks]

### Key Files
| File | Purpose |
|------|---------|
| [path] | [description] |
| [path] | [description] |

---

## How We Work Together

### Session Pattern
Start:  [e.g., /recap — check where we left off]
Work:   [e.g., collaborate, explain while working]
End:    [e.g., /rrr — write retrospective]

### Ask vs. Act
ASK before: [destructive actions, pushing, sending messages]
JUST DO IT: [reading files, tests, searches, drafts]

---

## Anti-Patterns (add lessons as you learn them)

- [First lesson you learn goes here]
- [Second lesson goes here]
- Start with none — add them when something goes wrong

---

## Deep Context (read only when needed)

| What | File |
|------|------|
| [topic] | [path/to/file.md] |
| [topic] | [path/to/file.md] |
```

---

## Growing Your CLAUDE.md Over Time

Your CLAUDE.md doesn't need to be perfect on day one. Here's the natural progression:

| Stage | What to Focus On | Typical Size |
|-------|-----------------|-------------|
| **Day 1** | Identity + Safety Rules | ~50 lines |
| **Week 1** | Add Workflow + Communication Style | ~100 lines |
| **Month 1** | Add Anti-Patterns from real experience | ~150-200 lines |
| **Ongoing** | Prune what's outdated, add new lessons | ~200-400 lines |

### Tips for Keeping It Effective

- **Test by observing**: After adding a rule, watch if Claude's behavior actually changes. If not, the rule might be too vague.
- **Be specific**: "Use 2-space indentation" works. "Write clean code" doesn't.
- **Prune regularly**: If a rule hasn't been relevant in a month, consider removing it. A shorter CLAUDE.md is a more effective one.
- **Every rule should pass this test**: "Would removing this cause my Oracle to make a mistake?" If not, cut it.
- **Keep it under 500 lines**: Beyond this, Claude starts losing track of individual rules. Use links to external files for detailed context.

### The Anti-Pattern Loop

The most powerful way to improve your CLAUDE.md:

```
Something goes wrong
        ↓
Understand WHY it went wrong
        ↓
Write a specific rule to prevent it
        ↓
Add it to Anti-Patterns section
        ↓
It never happens again
```

This is how experienced Oracle users build incredibly effective CLAUDE.md files — not by planning everything upfront, but by turning every failure into a permanent fix.

---

## Common Mistakes

| Mistake | Why It's Bad | Fix |
|---------|-------------|-----|
| CLAUDE.md is 1000+ lines | Claude ignores parts of it | Keep under 500 lines, link to external files |
| Identity buried at the bottom | Gets lost during compaction | Put identity at the TOP |
| Vague rules ("be careful") | Claude can't act on vague guidance | Be specific ("never push --force") |
| Pasting entire documentation | Wastes context window every session | Link to files instead |
| Never updating it | Stale rules accumulate | Review monthly, prune what's irrelevant |
| Only rules for Oracle | Misses the "contract" aspect | Add reminders for yourself too |
| No compaction recovery | Oracle loses identity after long sessions | Add recovery protocol |

---

## Further Reading

- [Claude Code: Managing Memory](https://code.claude.com/docs/en/memory) — Official documentation
- [Claude Code: Best Practices](https://code.claude.com/docs/en/best-practices) — Official tips
- [Path C: WSL2 Full Setup](path-c-wsl2.md) — Full Oracle setup including `/awaken`

---

## Navigation

| | |
|---|---|
| [Back to main guide](README.md) | Choose your setup path |
| [Path A: Desktop App](path-a-desktop.md) | Easiest setup |
| [Path B: VS Code Extension](path-b-vscode.md) | VS Code integration |
| [Path C: WSL2 Full Setup](path-c-wsl2.md) | Full Oracle with skills |

---

*"Every rule in a good CLAUDE.md exists because something went wrong without it."*
