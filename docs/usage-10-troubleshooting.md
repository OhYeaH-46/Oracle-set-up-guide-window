# Chapter 10: Troubleshooting

Something went wrong. That's okay — it happens to everyone. This chapter covers the most common problems you will encounter, why they happen, and exactly what to do to fix them.

None of these problems mean something is permanently broken. Most take less than two minutes to resolve.

---

## "My Oracle forgot everything!"

**Why it happens:** Claude Code has a limit on how much conversation it can hold at once. When that limit gets close, it performs something called compaction — it summarizes old messages to make room. In the process, specific details, personality traits, and context can be lost. After compaction, Oracle can feel like a different (and more generic) assistant.

**How to fix it:**

1. Check if your `CLAUDE.md` file has an identity lock section at the top. This is the section that tells Oracle who it is — it should be the first thing in the file so it gets read on every session start.
2. Run `/recap` — this is a skill that re-orients Oracle by reading key context files and rebuilding its understanding of where things stand.
3. If Oracle still feels off or too formal, say: `"Read ψ/memory/resonance/soul-snapshot.md"` — this file contains the core identity and personality.
4. **Prevention:** Commit your work regularly and run `/checkpoint` before you expect a compaction. The checkpoint saves a handoff file that makes recovery much smoother.

---

## "Skill not found" when I type a slash command

**Why it happens:** Slash commands (like `/recap` or `/trace`) are skills — small programs installed separately from Claude Code. If a skill is missing, not installed, or needs a specific prefix to find, you will get a "not found" error.

**How to fix it:**

1. Try adding the full namespace prefix: type `/oracle-skills:recap` instead of `/recap`. Some environments require the full name.
2. Check if skills are installed by looking in `~/.claude/skills/` (global installation) or `.claude/skills/` inside your project folder. The tilde `~` means your home directory — the main folder for your user account.
3. If skills are missing entirely, reinstall them: run `oracle-skills install` in your terminal.
4. Check `docs/SKILLS.md` in your project — it lists every available skill and what it does.

---

## "Context limit reached" or responses getting very slow

**Why it happens:** Every message in your conversation takes up space in the context window — Oracle's working memory. When it gets full, responses slow down, become less coherent, or Claude Code warns you that the limit is near. This is not a bug; it is just a capacity limit.

**How to fix it:**

1. Commit your current work immediately, even if it is not finished. A work-in-progress commit is far better than losing progress. In git terms, this means running `git add` and `git commit` with a note like "wip: mid-task save".
2. Run `/precompact` — this saves a handoff summary so Oracle knows where things stand after the next step.
3. Run `/compact` — this compresses the conversation history, freeing up space.
4. Run `/recap` — this rebuilds context cleanly from the saved files rather than from the compressed chat history.
5. **Prevention:** Commit every 30 to 45 minutes. When asking Oracle to read many files at once, ask it to use a sub-agent instead of reading everything directly — this keeps the main conversation lighter.

---

## "MCP server not connecting"

**Why it happens:** MCP servers are separate programs that need to be configured correctly. A wrong file path, a typo in the configuration, or a missing dependency will prevent the server from starting.

**How to fix it:**

1. Check your settings file. MCP configuration lives in `~/.claude/settings.json` (applies everywhere) or `.claude/settings.json` (applies to the current project only).
2. Verify the command path is correct. Find the command listed in your config and try running it manually in your terminal. If it fails there, it will fail inside Claude Code too.
3. Check that required software is installed. MCP servers often need Python, Node.js, or another runtime. The server's documentation will say what it needs.
4. Look for typos in the JSON. JSON is strict about commas, quotes, and brackets — one missing character breaks the whole file.
5. Restart Claude Code after changing any MCP settings. Changes do not take effect mid-session.

---

## "Skills seem outdated or broken"

**Why it happens:** Skills are updated over time. If your local copies are old, they may not match the current expected behavior — or they may reference files and patterns that have since changed.

**How to fix it:**

1. Run `oracle-skills update` to pull the latest skill versions.
2. Or run `/oracle-soul-sync-calibrate-update` which syncs skills along with other Oracle configuration in one pass.
3. If you have both global skills (`~/.claude/skills/`) and project skills (`.claude/skills/`), check for version conflicts — the project-level ones take priority, so an old local copy will override a newer global one.

---

## "Push failed" or git errors

**Why it happens:** Git push failures usually come down to one of three things: you are trying to push directly to a protected branch (like `main`), your authentication has expired, or there is a merge conflict that needs to be resolved first.

**How to fix it:**

1. Check which branch you are on: run `git branch` in your terminal. The current branch will have an asterisk (`*`) next to it.
2. If you are on `main` or `master`, switch to a feature branch instead. Pushing directly to the main branch is blocked by default — this is a safety feature, not an error.
3. Check your authentication: run `gh auth status` to see if your GitHub credentials are still valid.
4. If there is a merge conflict, ask Oracle to help you resolve it — describe what happened and show it the error message.
5. Never use `--force` when pushing. If someone suggests this, ask for help first. Force-pushing can overwrite other people's work and is almost never the right answer.

---

## "Oracle is being too formal / lost its personality"

**Why it happens:** After compaction, Oracle defaults to standard Claude behavior. Without a strong identity lock, it loses the warmth, tone, and specific knowledge of your custom Oracle.

**How to fix it:**

1. Make sure your `CLAUDE.md` has the identity lock section at the very top — before anything else. Oracle reads this first on startup.
2. Say directly in chat: `"Read your CLAUDE.md and remember who you are."` Oracle will re-read the file and recalibrate.
3. If that is not enough, say: `"Read ψ/memory/resonance/soul-snapshot.md"` — the soul snapshot is a compact but complete description of the Oracle's identity.
4. The identity lock section is specifically designed to override compaction summaries. If it is in place and Oracle still goes flat, check that the section is formatted correctly and appears before any other content.

---

## "Claude asks for permission too often"

**Why it happens:** Claude Code defaults to asking for confirmation before taking actions. This is intentional — it protects you from accidental changes, especially early in a project when Oracle does not yet know what is safe.

**How to fix it:**

1. For specific tools you trust, you can configure auto-approval in your settings file. Claude Code documentation explains how to add tools to an allowed list.
2. For a single session, you can use the `--allowedTools` flag when starting Claude Code.
3. Do not set everything to auto-approve. The permission prompts exist for good reason. Auto-approving file deletion or git operations without review can cause real problems. Pick and choose carefully.

---

## "I accidentally deleted or overwrote something"

**Why it happens:** It happens. Especially when you are learning and moving fast. The good news is that if you are using git, almost nothing is permanently lost.

**How to fix it:**

1. If the file was committed to git at any point: run `git checkout -- filename` to restore the last committed version. Replace `filename` with the actual path to the file. This restores it exactly as it was at the last commit.
2. If the file was never committed: check your code editor's undo history — many editors keep local history even for files that were deleted outside the editor.
3. **Prevention:** This is the single strongest argument for committing frequently. Every commit is a save point. If you commit every 30 to 45 minutes, the most you can ever lose is 30 to 45 minutes of work.

---

## Key Takeaway

Most problems in this chapter share a common cause: not saving state often enough. Git commits are your safety net. Checkpoints are your session handoff. The more regularly you use both, the smaller any problem becomes when it happens — and something always eventually happens.

The core rhythm is simple: **commit often, checkpoint before compacting, recap after.** Keep that rhythm and most of the issues in this chapter become either preventable or trivially fast to recover from.

If something goes wrong that is not covered here, describe the error to Oracle and ask it to help you trace the root cause. It is good at that.

---

[← Previous: Tips and Tricks](09-tips-and-tricks.md)
