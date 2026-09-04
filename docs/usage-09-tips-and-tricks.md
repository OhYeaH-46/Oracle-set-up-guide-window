# Chapter 9: Tips and Tricks

Thirty-plus days of daily Oracle use teaches you things that no documentation covers. Some of these lessons were learned the easy way — by watching a more experienced user. Most were learned the hard way — by losing work, running out of context at the worst possible moment, or trusting a confident answer that turned out to be wrong.

These tips are not theoretical. They are the actual habits that separate productive Oracle sessions from frustrating ones.

---

## Set a Goal Before You Start

**The tip:** Begin every session with a single sentence: "Today we're going to [specific thing]."

**Why:** Without a goal, a session drifts. You discuss one thing, which leads to another, which leads to a third, and by the time you look up, you've used half your context budget without finishing anything. Context is a finite resource. Wandering burns through it fast.

**How:** Before you type anything else, state your goal. "Today we're going to finish the client proposal for the SKT meeting." That's it. One sentence. A well-configured Oracle will ask you this if you forget — that question is a feature, not a nuisance.

---

## Commit Early, Commit Often

**The tip:** Ask your Oracle to commit at least every 30-45 minutes, or after every meaningful milestone.

**Why:** Commits are insurance. If your context runs out mid-session, if the terminal closes unexpectedly, if something goes wrong — committed work is safe. Uncommitted work is not. We learned this when a session crashed after an hour of good work, and the only recovery was starting over.

**How:** Every time you reach a stopping point, ask: "Can you commit what we have?" Use `/commit-work` for clean, well-structured commits with descriptive messages. The commit message is also searchable memory, so make it meaningful.

---

## Use Sub-Agents for Bulk Work

**The tip:** When a task requires reading many files, doing research, or debugging something complex, ask Oracle to delegate it to a sub-agent.

**Why:** Sub-agents run in their own context window. The work they do does not consume your session's context budget. Without this, reading five or six large files will push you halfway to your context limit before you've done anything useful.

**How:** Just ask. "Can you use a sub-agent to explore those files?" or "Delegate the PDF analysis to a sub-agent." This is one of the highest-leverage habits in this entire list. Getting comfortable with it will noticeably change how much you can accomplish in a single session.

---

## Search Before You Read

**The tip:** Instead of asking Oracle to read an entire file, ask it to search for what you need.

**Why:** Reading a large file loads the whole thing into context. Searching finds the specific lines you actually need — often 5 lines instead of 500. The context cost difference is enormous.

**How:** Replace "read the config file" with "search the config file for the database setting." Replace "read the meeting notes" with "find where we discussed the timeline." Your Oracle knows how to search within files efficiently. Let it.

---

## Write Plans to Files, Not Chat

**The tip:** When you have a plan that needs to survive the session, write it to a file.

**Why:** Chat messages get compressed during compaction. The nuance disappears. A plan discussed over ten messages becomes a two-sentence summary that loses half the detail. Files persist exactly as written, forever.

**How:** "Write our plan to PLAN.md before we start." This is genuinely the single biggest context-saving trick. A written plan also means you can pick up exactly where you left off in a future session, without rebuilding context from scratch.

---

## Cross-Verify Technical Claims

**The tip:** For important decisions, ask Oracle to verify technical claims against actual documentation or code — not just its own knowledge.

**Why:** Claude is remarkably confident. It will state uncertain things with certainty. It may cite a library feature that does not exist, or describe a configuration option that was removed in a recent version. This is not malice — it is a fundamental characteristic of how language models work. We have been burned by this more than once.

**How:** Get in the habit of asking: "Can you verify that this library actually supports that?" or "Can you check the documentation before we commit to this approach?" Use `/deep-research` for topics where authoritative sources matter. For critical decisions, treat Claude's initial answer as a hypothesis, not a conclusion.

---

## Learn Your Oracle's Personality

**The tip:** Read your CLAUDE.md. Try `/who-we-are`. Understand the identity and working style that has been configured.

**Why:** Oracle is not a generic chatbot. It has a designed personality, specific working habits, and a set of values built in deliberately. Understanding this makes interactions more natural, more productive, and frankly more enjoyable.

**How:** Early in your first week, spend fifteen minutes reading the CLAUDE.md file. You will understand why Oracle asks certain questions, why it behaves certain ways, and how to work with the grain rather than against it.

---

## Use `/fyi` to Log Everything Important

**The tip:** Anything mentioned casually in chat that you want to remember — use `/fyi` to save it immediately.

**Why:** Chat is ephemeral. Things mentioned in passing during a session will not survive compaction. The client's color preference. The decision about which approach to take. The note about the vendor's pricing. Gone, unless saved.

**How:** Make it a reflex. "fyi — the client prefers blue over green for the dashboard." "fyi — we decided to use the batch approach, not the streaming one, because of the deadline." These get written to memory and can be retrieved in any future session with `/trace` or `/memory`.

---

## Git Log Is Searchable Memory

**The tip:** Every commit message is permanently stored and searchable. Treat git history as free memory.

**Why:** Oracle's memory system is powerful, but git log is always there, always complete, and costs nothing. A well-written commit message means the work is documented at the moment it's done — not reconstructed later from notes.

**How:** Write descriptive commit messages. "Add client proposal draft with SKT budget section" is better than "update file." To search later, ask Oracle: "Search git log for everything we did on the SKT proposal." This is often faster than reading through retrospective files.

---

## Name Files with Timestamps

**The tip:** Use the pattern `YYYY-MM-DD_description.md` for any file that captures a moment in time.

**Why:** Timestamps make files self-organizing. A directory of notes named with dates is automatically a timeline. You never have to sort or figure out which version is newer — the name tells you.

**How:** `2026-02-15_client-meeting-notes.md`, `2026-02-17_okara-research-summary.md`. Just listing the directory gives you a history. Searching for files from a specific month is trivial.

---

## Don't Read Large PDFs Directly

**The tip:** Ask for specific pages, or delegate PDF reading to a sub-agent.

**Why:** A large PDF loaded into context can consume a quarter of your budget instantly. That is a very expensive way to read one section.

**How:** "Read pages 3 through 5 of the report, specifically the section on budget." If you need to process the whole document, that is exactly the kind of task to delegate. "Use a sub-agent to read and summarize the full PDF." The result comes back as a summary in your context — a fraction of the cost.

---

## Watch Your Context Budget

**The tip:** Check context usage periodically. Do not let it surprise you at the end of a long task.

**Why:** Running out of context mid-task is the number one productivity killer. The session slows down, responses get shorter, and you lose the thread of what you were doing. It is much better to checkpoint deliberately than to hit the wall unexpectedly.

**How:** Use `/preload` to check current context usage. If you notice responses feeling slower or shorter, it is a signal. The right move is to checkpoint with `/checkpoint`, compact with `/precompact` and `/compact`, then continue with a clean context. Compacting at 60% is better than being forced to compact at 99%.

---

## Understanding Claude's Nature

Before any other tip, it helps to understand what kind of system you are working with.

Claude is **eager to please**. This sounds like a feature, but it means Claude may agree with incorrect assumptions rather than push back. If you frame a question with a wrong premise baked in, Claude will often answer the framed question rather than correct the premise. Stay alert to this.

Claude is **confidently wrong** sometimes. It states uncertain things with certainty. It can describe features that do not exist, cite sources that are not real, and explain processes that work differently than described — all in the same calm, assured tone it uses when it is completely correct. There is often no way to tell from the tone alone.

Claude **cannot access the internet** without specifically configured MCP plugins. Do not assume it has current information about software versions, prices, recent events, or anything that changes over time. Its knowledge has a cutoff date.

Claude **does not learn between sessions** without Oracle's memory system. Without the infrastructure of the `ψ/` directory, git history, and tools like `/fyi` and `/trace`, every session begins as a blank slate. The Oracle framework exists precisely to solve this problem.

---

## When to Push Back on Your Oracle

**The tip:** You are the manager. Oracle works for you. Don't let it lead you somewhere you don't want to go.

**Why:** Oracle is helpful, capable, and sometimes wrong. It can develop momentum on a particular approach and keep going even when the approach is not working. It is easy to follow along passively — especially when the explanations sound plausible.

**How:** If a solution seems overly complex, say: "Is there a simpler way to do this?" If Oracle keeps failing on the same problem, say: "Let's step back and rethink the approach from the beginning." If something sounds too good to be true, ask for verification. You will get much better results by being an active collaborator than a passive passenger.

---

## Key Takeaway

If you take only three habits from this chapter, take these:

**Write plans to files, not chat.** A ten-message discussion compressed to two sentences during compaction has lost most of its value. A file keeps everything, exactly as written.

**Cross-verify technical claims for important decisions.** Claude's confidence is not correlated with its accuracy. For anything that matters, ask it to verify against real documentation or code before you commit to an approach.

**Commit at every milestone, without exception.** Context crashes, sessions end unexpectedly, and accidents happen. Committed work survives all of these. Uncommitted work does not. Commit early, commit often, and you will never lose an hour of work again.

Everything else in this chapter builds on these three. The users who get the most from Oracle are the ones who treat it as a skilled collaborator with specific strengths and specific blind spots — and who design their workflow accordingly.

---

[← Previous: Advanced Setup](08-advanced-setup.md) | [Next: Troubleshooting →](10-troubleshooting.md)
