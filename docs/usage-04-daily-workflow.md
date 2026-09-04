# Chapter 4: Daily Workflow

This is the most important chapter in the guide. If you read only one chapter, make it this one.

Everything here comes from real experience — 30+ days of working with an Oracle daily, learning the hard way what causes memory loss, wasted effort, and lost work. The patterns in this chapter aren't theory. They are lessons that cost actual time to discover.

---

## The Session Lifecycle

Every productive session follows a simple rhythm:

```
Start → Plan → Execute → Checkpoint → End
```

Think of it like a real workday:

- **Start**: Check your notes from yesterday, orient yourself, set a goal for today
- **Plan**: Write down what you're going to do — in a file, not just in the chat
- **Execute**: Do the actual work
- **Checkpoint**: Save your progress regularly, like hitting Ctrl+S on a document
- **End**: Write a summary and leave a handoff note for your next session

If you skip any of these, you pay for it later. The End step in particular — people skip it constantly because they're tired or in a hurry. Then next session they spend 20 minutes trying to remember where they left off. The `/rrr` command exists precisely to prevent that.

---

## Starting a Session: The /recap Rhythm

Always begin every session with `/recap`.

`/recap` orients your Oracle. It reads recent handoff notes, checks the current project state, and tells you what it remembers. Think of it as your Oracle picking up its notes before a meeting — making sure it walks into the room ready, not blank.

After `/recap`, set a clear goal. Say it explicitly:

```
Today we're going to finish the report template and review the draft contract.
```

This one habit changes everything. A specific goal keeps both you and your Oracle focused. It prevents the "we worked for two hours and ended up somewhere completely different" problem.

A well-configured Oracle will actually ask you for a goal if you don't set one. That's intentional. A good Oracle doesn't just start executing — it asks "what are we doing today?" first.

---

## Planning: Files, Not Chat

This is perhaps the single most important habit in this entire guide.

**Write your plans in a file. Not in the chat.**

Here's why. The chat conversation has limited memory — it's like a whiteboard in a meeting room. You can write things on it, point at it, reference it. But when the session gets long, older content gets erased to make room for new content. Your plans, decisions, and instructions from the beginning of the session can disappear.

A file is a notebook. It stays. It never gets compressed or erased. Your Oracle can read it any time.

The workflow looks like this:

1. Start a session
2. Ask your Oracle to create a `PLAN.md` file for this task
3. Describe what you want to achieve
4. Break it into checkpoints: "After step 1, save. After step 2, save."
5. Say "follow the plan" and let your Oracle execute

If you need to make a significant decision mid-session — "we decided to use Format A instead of Format B because..." — put it in a `DECISIONS.md` file. This prevents one of the most exhausting patterns in Oracle work: re-debating the same decision three sessions in a row because no one wrote it down.

Chat for plans = whiteboard that gets erased.
Files for plans = notebook that stays forever.

---

## Executing: Context-Lean Patterns

Your Oracle has limited "desk space." This desk space is called the context window — it's how much information your Oracle can hold in mind at once. When the desk fills up, older things slide off.

Smart execution means using that desk space for the actual work, not for administrative overhead.

| Instead of... | Do this | Why |
|---|---|---|
| Reading entire files before starting | Search first, then read only the specific section you need | Saves up to 80% of context space |
| Reading many files yourself | Ask your Oracle to delegate to sub-agents | Sub-agents use their own separate desk space |
| 20 messages of planning in chat | Write the plan to a file, then say "follow the plan" | Long discussions burn context before any work is done |
| Debugging in circles (5+ back-and-forth attempts) | Ask your Oracle to delegate debugging to a sub-agent | Error messages and stack traces are context killers |
| Pasting huge error logs into the chat | Ask for a summary of the key issue only | Logs are long — they eat space fast |
| Repeating the same instructions every message | Put them in `CLAUDE.md` once | Redundant messages waste space on every turn |

Sub-agents deserve a special mention here. They are like assistants your Oracle can summon to handle specific tasks. The crucial point: **sub-agents have their own desk space**. When your Oracle delegates "analyze these 10 files" to a sub-agent, your Oracle's own desk stays clean. The sub-agent does the heavy reading and returns with only the useful answer.

If you have a task that involves reading many files, searching many places, or parsing long outputs, ask your Oracle to use a sub-agent. This is not a shortcut — it's the right tool for that kind of work.

---

## Checkpointing: Save Early, Save Often

Every 30-45 minutes, or at every meaningful milestone, commit your work.

"Commit" means creating a save point in git — a snapshot of your files at this exact moment. Think of it like a save point in a video game. If something goes wrong later, you can return to any save point without losing the work up to that moment.

Here's the thing most people don't realize at first: **your Oracle might lose its short-term memory at any moment**. If the context window fills up and compresses, it might forget what it was doing. If you close the terminal accidentally, it might lose track of what was in progress.

But git commits survive all of that. The files are safe. The code is safe. The only thing your Oracle loses is the memory of *how* it got there — and the handoff note will cover that.

A practical checkpointing rhythm:

- After completing step 1 of the plan → commit
- After completing step 2 → commit
- After 30-45 minutes, even if a step isn't finished → "work in progress" commit
- Before doing anything that changes many files at once → commit first, so you have a safe rollback point

Update `PLAN.md` to mark what's done as you go. This makes `/recap` much more useful in future sessions.

---

## When Context Gets Heavy

You'll notice warning signs before your Oracle's context window runs out:

- Responses start to feel slower or more vague
- Your Oracle references something from earlier in the session incorrectly
- You see a compaction warning appear in the interface
- Your Oracle seems to have forgotten a decision you made an hour ago

When this happens, don't push through. Stop and do the following:

1. Commit your current work — even unfinished work. A "work in progress" commit is infinitely better than no commit.
2. Run `/precompact` — this saves a handoff note capturing where you are and what comes next.
3. Run `/compact` — this compresses the conversation, clearing space.
4. Run `/recap` — this rebuilds your Oracle's awareness cleanly from the handoff note and saved files.

This process is like clearing your physical desk when it gets too cluttered. You take everything off, sort through it, keep only what you're actively working on right now, and file the rest. When you sit back down, you can think clearly again.

The key insight: compaction is not a failure. It's a scheduled maintenance step. Plan for it. Build your workflow around it.

---

## Ending a Session: /rrr and Handoffs

Run `/rrr --forward` at the end of every session. No exceptions.

`/rrr` stands for Retrospective, Read, and Reflect. The `--forward` flag adds a handoff note for the next session. Together, they produce:

- A **retrospective**: what happened, what was decided, what was learned
- A **handoff**: what the next session needs to know before it starts

A good handoff note contains three things:
1. Where you stopped
2. What to do next
3. Key decisions already made (so you don't re-debate them)

The handoff is what makes your `/recap` command powerful the next morning. Without a handoff, your Oracle starts the next session somewhat blind. With a handoff, it starts oriented, confident, and ready to continue.

Skipping `/rrr` at the end of a session is like leaving your desk at the end of the day without writing any notes — and then being surprised the next morning that you don't remember what you were doing.

---

## The Golden Anti-Patterns

These are the habits that cost real time before people learn better.

| Anti-Pattern | Cost | Better Approach |
|---|---|---|
| "Read the entire codebase before starting" | Fills up context before any work is done | Search for what you need; read on demand |
| Chat back and forth for 20 messages before doing anything | Discussion eats context before work begins | Write plan to file, then execute |
| Debug in circles (5+ attempts in chat) | Error output floods context | Delegate debugging to a sub-agent |
| Never commit until everything is done | Lose work when context runs out | Commit at every milestone |
| Paste huge error logs directly | Context killer — logs are enormous | Ask for a summary of the key issue |
| Repeat instructions every message | Redundant waste on every turn | Put it in `CLAUDE.md` once |
| Skip `/rrr` because you're tired | Next session starts blind | 5 minutes now saves 20 minutes tomorrow |

---

## A Day in the Life

Here's what a well-run session looks like from the outside:

```
9:00 AM  — Open terminal, run: claude
9:00 AM  — /recap to orient
9:01 AM  — "Today we're building the report template"
9:05 AM  — Write plan to PLAN.md (3 steps, clear checkpoints)
9:10 AM  — Start working on step 1
9:45 AM  — Step 1 done → commit progress, mark PLAN.md
10:30 AM — Step 2 done → commit, mark PLAN.md
11:00 AM — Context getting heavy → commit WIP, /precompact, /compact, /recap
11:05 AM — Continue step 3 with fresh context
12:00 PM — Done → /rrr --forward to wrap up
```

Two hours of productive work. Regular save points throughout. Clean ending with a handoff. Next session starts in 5 seconds, not 20 minutes.

Compare that to the alternative: two hours of working with nothing committed, no plan written down, session crashes or gets compressed, work partially lost, next session spent reconstructing what happened.

The difference isn't talent or effort. It's just the habit.

---

## Key Takeaway

If you remember nothing else from this chapter, remember these five things:

1. **Start with `/recap`** — always orient your Oracle before doing anything
2. **Plans go in files, not chat** — the whiteboard gets erased; the notebook stays
3. **Commit every milestone** — your Oracle might lose short-term memory; git commits don't forget
4. **When context feels heavy, compact immediately** — don't push through
5. **End with `/rrr --forward`** — 5 minutes now saves 20 minutes of confusion tomorrow

Memory loss is the number one cause of wasted time in Oracle work. Every habit in this chapter exists to prevent exactly that. Learn them early and they'll save you hours every week.

---

[← Previous: Your First Session](03-your-first-session.md) | [Next: Skills and Commands →](05-skills-and-commands.md)
