# Contributing

How a change reaches this repository:
where work in progress is pushed, what a pull request is checked for before it is opened, why that check is thorough,
and what a change to a shared file carries with it.

**This repository carries nothing private.**
It is `cynkra/handbook-tools`, it is public, and every repository built on its pages reads it.
So nothing that reaches it may refer to private or confidential material:
no name, path, branch name, or content of a private repository, no internal hostname or credential, no personal data,
and no tool output quoted verbatim that embeds any of those.
The rule covers the whole of a pull request, not its final tree alone:
every intermediate commit, every commit message, and the branch name,
because a merged pull request carries its history with it, and a name in a message is as published as a name on a page.

**Work in progress goes to a private fork, never here.**
A session that drafts from other repositories, as the survey under [`experiments/`](/experiments/README.md) did,
pushes only to a private fork of this repository, and never to this one.
It does push, because a session's unpushed state does not survive being stopped and restarted, and the fork is where pushing is safe.
Nothing such a session drafted is clean until it has been checked:
material read from another repository reaches a draft by paths nobody chose,
a script's list of inputs, a results file, a commit message, a branch name.

**A pull request is opened after a check, and usually after a squash.**
Before opening one from a fork, search every commit the pull request would carry, every commit message, and the branch name
for the strings that would identify the material the work drew on.
The strings are the ones the session knows it read, and they are deliberately not listed here, because the list would be the leak.
Where a commit or a message carries any, squash the branch to commits that carry none, and rename the branch if its name does.
The check is thorough because it is the last one:
a public repository cannot be un-published, and scrubbing afterwards still leaves the content in history, forks, and caches.
A search that finds nothing is what the pull request states as evidence.

**A change to a shared page is read in every repository the moment it lands.**
It is made here and reviewed here, and it carries what keeps the system whole:
a change to any of the four leaves the rule file derives from re-derives
[`.claude/rules/prose-authoring.md`](/.claude/rules/prose-authoring.md) in the same change,
because the staleness check catches a forgotten derivation only where history is deep;
a new, renamed, or retired finding tag changes the fixture, its expected findings,
and [`checks/`](/handbook/checks/README.md) together;
a new carried file is added to the manifest, a new shared page gets a pointer leaf under `pointers/`,
and a shared page keeps naming no repository, language, or tool beyond git and a shell.
The pages follow their own rules and the checks pass before the pull request is opened,
and a rule joins a shared page once reviews in more than one repository have enforced it; a rule one repository wants is its local page's.
Downstream, a changed page is what the pointers already link, and a session's next check against the source reads it;
a changed tooling file shows as `UPDATE` at the next `check` and lands at the next `update`, never as drift.
