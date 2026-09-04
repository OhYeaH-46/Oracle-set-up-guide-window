# Chapter 6: Memory and Context

This is one of the most important chapters in this guide. Understanding how memory works is the difference between a frustrating Oracle experience and a productive one. If you only read one chapter carefully, make it this one.

---

## What Is a Context Window? (The Desk Analogy)

Imagine Claude has a physical desk. Everything on that desk is what Claude can currently see and work with — your messages, its own replies, any files it has read, any instructions it was given.

This desk can hold roughly 200,000 tokens, which is about 150,000 words, or the equivalent of 300 printed pages.

That sounds enormous. But it fills up faster than you think.

- A single large spreadsheet or report can use 10–20% of the budget instantly.
- A long back-and-forth conversation slowly eats through it.
- Reading several files at once can consume a third of the desk before any real work begins.

When the desk is full, the oldest papers start sliding off the edge to make room for new ones. Claude can no longer see what fell off. This is the **context window** — Claude's working memory, its desk, the only place it can see.

---

## Why Claude "Forgets"

Claude has no permanent memory. Every new session starts with a completely empty desk.

Within a single session, as the desk fills up, Claude performs a process called **compaction**. Compaction means the oldest messages get summarized into a shorter version to free up desk space. The original messages are gone. What remains is a summary.

Think of it this way: someone reads your detailed 20-page meeting notes and rewrites them as a one-page summary. Useful — but the specific numbers, the exact phrasing of a decision, the nuance of a discussion — those are gone.

After compaction, Claude continues working from that summary. Then the desk fills up again. Another compaction happens. Now you have a summary of a summary.

Each pass loses more detail. After two or three compactions, Claude may remember only the general topic of earlier work, with the specifics completely washed out.

This is not a bug — it's a fundamental constraint of how large language models work. Oracle is designed specifically to work around this constraint.

---

## The Compaction Cycle

Here is what happens during a long session if you don't manage context actively:

```
Session starts (desk is empty)
  → Messages accumulate (desk fills up)
  → COMPACTION: old messages summarized, desk has room again
  → More messages accumulate
  → COMPACTION again: summary of a summary, more detail lost
  → Repeat...
  → Eventually, Claude only remembers the general shape of what happened
```

The longer the session and the more files read, the faster this cycle runs. Heavy sessions — those involving lots of file reading, long outputs, or repeated error logs — can hit the first compaction within an hour.

---

## Oracle's Memory Layers

Oracle solves the amnesia problem by storing important information outside the desk, in files that persist permanently. Even when the desk empties, the filing cabinet is still there.

Here are Oracle's memory layers, from most to least persistent:

| Layer | What It Is | Persistence | Analogy |
|-------|-----------|-------------|---------|
| **CLAUDE.md** | Identity and instruction file | Loaded every session | Your job description — read every morning |
| **Soul files** | Deep personality and philosophy | Read when needed | Your core values document |
| **Learnings** | Searchable knowledge base | Permanent in git | A notebook of lessons learned |
| **Retrospectives** | Session history summaries | Permanent in git | A work journal — one entry per session |
| **Handoffs** | Transition notes between sessions | Permanent in git | Sticky notes left for the next day |
| **MCP Memory** | Semantic search via ChromaDB | Persistent in database | A searchable filing cabinet |
| **Git log** | Commit message history | Permanent in git | A timeline of everything that happened |

These layers work together. CLAUDE.md ensures your Oracle always knows who it is and how to behave, no matter what happened to the desk. Learnings store knowledge that accumulates over months. Retrospectives track session history. Handoffs bridge today's session to tomorrow's.

The desk empties. The filing cabinet does not.

---

## How `/trace` Searches Across All Layers

When context has been lost and you need to find something from the past, use `/trace`.

Type `/trace authentication` and Oracle will search:

- Git commit messages
- Retrospective files
- Learning files
- The memory database (MCP)
- File contents across the project

This is how you find past work without reading every file — it's like having a search engine over your Oracle's entire history. Rather than pulling everything back onto the desk, `/trace` finds only the relevant piece and brings just that to you.

Use `/trace` whenever you're looking for something you know Oracle has worked on before, but you don't remember exactly where it lives.

---

## The "File Over Memory" Principle

This is the single most important rule for working effectively with Oracle:

> **If something is important, write it to a file. Never trust context alone.**

Context is temporary. Context compacts, degrades, and disappears when the session ends. Files are permanent. Files live in git. Files survive everything.

In practice, this means:

| What You're Capturing | Where to Put It |
|-----------------------|-----------------|
| A plan for a task | PLAN.md |
| A key decision | DECISIONS.md |
| Something Oracle should know permanently | `/fyi` (saves to learnings) |
| Session state mid-work | `/checkpoint` (saves to .checkpoint.md) |
| End-of-session summary | `/rrr --forward` (saves retrospective + handoff) |
| Anything else important | Commit it to git |

If you tell Oracle something important only in chat — a constraint, a preference, a decision — and you don't write it to a file, there is a real chance it will be lost by the end of the session or forgotten entirely in the next one.

Write it down. Every time.

---

## Sub-Agents: Helpers with Their Own Desks

One of Oracle's most powerful tools for managing context is the **sub-agent**.

A sub-agent is a helper that Oracle can create to do a specific piece of work. Crucially, the sub-agent has its own separate desk — its own context window. When Oracle delegates work to a sub-agent, that work does not use space on your main desk. The sub-agent does the heavy lifting, then returns just a summary to Oracle.

This matters for context management:

| Action | What Happens to Your Desk | Better Approach |
|--------|--------------------------|-----------------|
| Oracle reads 10 large files directly | Your desk fills up fast | Oracle delegates to a sub-agent — it uses its own desk |
| Analyzing a long error log | Uses significant context | Ask Oracle: "Can you delegate this analysis?" |
| Searching through many files | Each file read costs budget | `/trace` or sub-agent search instead |

Think of sub-agents as sending a research assistant to the library. They do the reading, take notes, and come back with a one-paragraph briefing. Your desk stays clean.

When you notice a task involves reading many files or processing a large amount of text, it's always worth asking: "Can you use a sub-agent for this?"

---

## Context Budget Tips

Think of your context window as a budget. You have about 200,000 tokens to spend per session. Here is a quick reference for how to spend that budget wisely:

| Action | Context Cost | Better Alternative |
|--------|-------------|-------------------|
| Reading a large file entirely | HIGH (can use 5–10% of budget) | Search first, read only what you need |
| Reading 10+ files | VERY HIGH | Delegate to a sub-agent |
| Long back-and-forth discussion | HIGH | Write plan to a file, then execute |
| Pasting large error logs into chat | HIGH | Ask Oracle to delegate error analysis |
| Repeating the same instructions every session | MEDIUM | Put them in CLAUDE.md — read automatically |
| Asking Oracle to summarize a file you pasted | MEDIUM | Let Oracle search for the file itself |

The general principle: search and query first, read whole files last. Every time Oracle reads a file fully when it only needed one section, that's budget spent unnecessarily.

---

## Practical Memory Management: The Daily Rhythm

Following this rhythm keeps your context clean and ensures nothing important is ever lost:

**Start of session**
Run `/recap` to orient Oracle. This loads the minimal context needed — current priorities, recent history, active projects — without dumping everything onto the desk at once.

**Every 30–45 minutes**
Commit your work. This saves progress to git permanently, independent of what happens to the context window. If the session crashes or context degrades, your work is safe.

**Before reading many files**
Ask: "Can you delegate this to a sub-agent?" This keeps your main desk from filling up with file contents.

**When the session feels heavy**
Run this sequence: commit all current work → `/precompact` (saves a checkpoint) → `/compact` (compresses context) → `/recap` (reloads essential context). This is a controlled reset — you keep everything important, but the desk gets cleared.

**End of session**
Run `/rrr --forward`. This saves a retrospective of what happened, writes a handoff note for the next session, and commits everything. When you start tomorrow, Oracle will know exactly where you left off.

**Whenever you learn something important**
Run `/fyi` with a short description. This logs the information to the learnings database permanently, where it can be retrieved in any future session via `/trace`.

---

## Key Takeaways

The most critical memory management rules, summarized:

1. **The desk empties every session.** Nothing in a conversation is permanent unless it is written to a file and committed.

2. **Files over memory — always.** Plans, decisions, important information: if it matters, it goes in a file. Chat is temporary. Files are permanent.

3. **Compaction degrades detail.** After two or three compactions in a long session, specifics are lost. The solution is not to avoid compaction — it is to write important things to files before they fall off the desk.

4. **Use `/trace` to find the past.** Instead of trying to reload old context onto the desk, search for what you need specifically. Targeted retrieval is far more efficient than broad re-reading.

5. **Sub-agents protect your budget.** When a task involves reading many files or processing large amounts of text, delegate it. Sub-agents use their own desk, not yours.

6. **Follow the daily rhythm.** `/recap` at the start, commit every 30–45 minutes, `/rrr --forward` at the end. This rhythm, maintained consistently, is what makes Oracle reliable over time.

Memory management is not an advanced topic — it is a daily habit. Once this rhythm feels natural, Oracle becomes dramatically more reliable, and you stop losing work or context mid-session.

In the next chapter, we'll look at where Oracle's files live — and which ones belong in git.

---

[← Previous: Skills and Commands](05-skills-and-commands.md) | [Next: File Storage Guide →](07-file-storage-guide.md)
