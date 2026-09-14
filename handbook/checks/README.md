# The checks

What [`check-handbook.sh`](/.claude/skills/docs-consistency/scripts/check-handbook.sh) checks mechanically, what each finding means,
how a session and CI run it, what it exempts and how a repository adds to that, and what stays judgment.

**One script, one list of findings, one exit status.**
The script is POSIX shell and needs git and the usual shell tools, and nothing of the host project's language.
It runs from anywhere inside a repository,
takes its files from git (tracked ones plus new ones that are not ignored, minus the ones no longer on disk),
prints one line per finding as a tag, a path, and what is wrong, and exits non-zero when it printed any.
A clean run prints one summary line.
Every finding names a rule in [`meta/handbook/`](/handbook/meta/handbook/README.md), and the rules are the authority when the two disagree.

* `MISSING`: a directory under `handbook/` without a `README.md`.
* `IGNORED`: a page under `handbook/` that git ignores, which every other check would pass and every clone would lack.
* `UNLISTED`: a subdirectory absent from its parent's child list, the list being the lines that start with a list marker.
* `HEADING`: a `##` heading on an internal node, which is the mechanical trace of a node accreting prose.
* `UPWARD`: a link in a handbook page that climbs with `../`.
* `DANGLING`: an internal link whose target does not exist, in a handbook page or in a backreference outside the tree.
* `ANCHOR`: a fragment that matches no heading of the file it points into.
  The slug keeps a non-ASCII letter as written, so a heading with an uppercase one is the case the approximation misses.
* `STALE`: a derived document older than one of its `derived_from:` sources, and `SOURCE`: a source that no longer exists.
  The dates come from git history, so a shallow clone cannot age a document by a change before its boundary; the script says so.
* `ORPHAN`: a document outside the tree with no `derived_from:` list, no link resolving into `handbook/`,
  and no `README.md` above it that links into the tree and names it.
* `MIDPAGE`: a deepen line that is not the last paragraph of its page, or a second one.
* `UNREGISTERED`: an experiment directory the registry does not name, and `GONE`: a registry line whose directory is missing.
* `EM-DASH`: an em dash in any tracked text file, prose or code.
  The check is on by default and dropped with `--no-em-dash`; commit messages are outside its reach.

Two reports print without judging:
`board` lists every page with its `status:` and `verified:` front matter, empty until a page carries them,
and whether it still carries a deepen line;
`lines` lists the deepen lines themselves, so that their promises can be checked against the tracker.

**Exemptions are the repository's, by kind, and they carry their reasons.**
[`.handbook-ignore`](/.handbook-ignore) at the repository root holds one line per exemption, a glob or `kind: glob`.
A bare glob skips the path in every check, because its links are a generator's or a third party's, not this repository's to fix.
`orphan:` exempts a path from the orphan check alone, which is where generated Markdown and a tool's own directories belong,
and `em-dash:` from the em dash check alone, which is where vendored tooling and quoted material belong;
a repository that permits em dashes altogether writes `em-dash: *`.
Built in, and always skipped by the orphan check, are only what the shared rules exempt without a repository's say:
a license, and what a run captured beside an experiment record.
Write the reason beside the pattern,
because an exemption whose rationale lives in a merged pull request gets re-argued every time someone reads the file.

**Two callers, one script.**
A session runs it through the `docs-consistency` skill, which then works the judgment checks.
CI runs it on every pull request from the workflow stub, with the full history checked out so that `STALE` can fire,
and refuses the merge on a finding.
A second job checks out the source, which is public, with its full history, and runs its vendoring script's `check`,
so that a carried file edited in place is refused too ([`adoption/`](/handbook/adoption/README.md));
its own job, so that the source's files are never read as the repository's and each check reports its own result.
The same list reaches both, so a finding CI reports is one the session could have seen.

**What stays judgment.**
Whether a topic is homeless, whether a scope sentence still admits its children, whether an entry restates what it links,
whether a document that merely points should be derived, and whether a source-file header says what its file does.
The skill carries that reading, and nothing here pretends to.

*To deepen: state the generated in-place index once a portable generator exists.*
