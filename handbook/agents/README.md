# What a repository ships for an AI session

The files an AI session loads in a repository built on the shared pages:
the router files, the path-scoped rule, the skills and the commands that invoke them, and why each is shaped as it is.

**The router files route; they are not homes for facts.**
`AGENTS.md` is the orienting document for any coding agent, in the [agents.md](https://agents.md/) format,
and `CLAUDE.md` is Claude Code's entry point, deferring to it in two sentences.
Both exist so that an agent landing in the repository finds the handbook and the few things it needs before it can read anything else.
What they carry is the first five minutes: the leaves a session needs before its first edit, and the documentation rule in one sentence.
A durable fact written into either now lives in two places, and the router is the copy nobody re-reads when the fact changes.
Both are stubs: installed once, and the repository's own from then on ([`adoption/`](/handbook/adoption/README.md)).

**The rule file loads on a path match, and is derived.**
[`.claude/rules/prose-authoring.md`](/.claude/rules/prose-authoring.md) is the short form of the four shared leaves that own the rules,
and it declares them in a `derived_from:` list so that the staleness check ages it when any of them moves.
Claude Code loads it when a session touches a file that carries prose, which is a trigger a handbook leaf cannot express,
so the rules arrive at the moment of writing without every session paying for them.
It is carried unchanged into every repository, which is why it names [`meta/local/`](/handbook/meta/local/README.md) for what differs,
and its `derived_from:` list names the pointer leaves there, which stand for the pages here.
A wrong sentence in it is fixed at the leaf and re-derived, never patched in place.

**Skills carry the judgment; a script beside them carries the mechanics.**
`docs-consistency` is the enforcement arm of the rules:
it runs the check script and then reads for what no string comparison can answer.
`handbook-update` drives the vendoring script from inside a session and then does what no script can:
it reads the source's changes since the marker's date against this repository's pages, and settles each,
so that the marker's new date means the whole handbook was checked, not that files were copied.
`handbook-adopt` lives in the source only and converts a handbook that predates the shared pages,
reading its old pages for what stays local before the install replaces them with pointer leaves.
`/docs:check` and `/handbook:update` are the slash commands that invoke them, and each is the invocation and nothing more.
A carried skill is never hand-edited, because the next update overwrites it;
a change to one is made in the source and reaches every repository from there.
A skill a repository owns is ordinary source, changed through a pull request like anything else,
and the marker's list of carried files is what tells the two apart.

**Never invent a new top-level navigation file.**
`PROJECT.md`, `SPEC.md`, `OVERVIEW.md`, `DESIGN.md`, and their like are all the same mistake:
the root files already are the navigation contract, and a durable fact belongs on the handbook leaf that owns its topic.
A new file at the root is a second navigation contract that disagrees with the first.
