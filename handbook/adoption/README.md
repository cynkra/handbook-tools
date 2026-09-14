# Adoption

How a repository builds its handbook on the shared pages and keeps it current:
the pointer leaves that stand in for the shared pages, the tooling carried in unchanged, the stubs installed once,
the marker that records when the whole handbook was last checked against the source, the four verbs,
what an adopting repository fills in, and the way in from a handbook that predates the shared pages.
What was measured before this design was chosen is [`experiments/2026-09-12-drift-survey/`](/experiments/2026-09-12-drift-survey/README.md).

**The shared pages are referenced, not copied.**
The six pages that state the rules, the forms, the growth moves, authoring, style, and the evidence convention have one home, here.
An adopting repository carries a pointer leaf at each of their paths under `handbook/meta/`:
its H1 and scope sentence, the link to the page here, and the link to the repository's local page.
The paths stay, so every link into `meta/` keeps resolving, and the text lives once,
so a rule improved here is improved everywhere the moment it lands, with no update to carry it.
A reader who follows the pointer reads *this repository* on the shared page as the one they came from,
and `meta/local/` as that repository's local page; the page says so under its H1.
The survey behind this choice found the same pages in five wordings across eleven repositories,
which is what a copy comes to, however carefully carried.

**Three classes of file, and a manifest that names them.**
[`scripts/manifest`](/scripts/manifest) lists every file the vendoring script touches, one per line, with its class first.
A *pointer* is the leaf described above, kept under [`pointers/`](/pointers/handbook/meta/handbook/README.md) here at its target path,
and overwritten on every update so that its scope sentence follows the page's.
A *shared* file is tooling, copied byte for byte and overwritten on every update:
the rule file, the two skills with the check script, and the two commands.
A *stub* is installed when absent, never overwritten, and never required: a repository that declines one keeps its own file in its place.
The stubs are the router files, the handbook root, the `meta/` index, the glossary, the local page, the experiments registry,
the ignore file, and the CI workflow.
Everything else in a repository is its own, and the script never touches a file the manifest does not name.

**The marker records when the whole handbook was last checked against the source.**
`.handbook-source` at the repository root records the source repository and its URL,
the source's commit and that commit's date as `source-date`, the day of the check as `checked`, and the files carried.
The source is a moving target, and the default is its latest state:
the pointers link the default branch, and a session updating a repository reads the source's changes since `source-date`
and reconciles the handbook with them ([`agents/`](/handbook/agents/README.md)).
Where a page here and a repository's page are found to disagree, the date says which state of the source that repository last agreed with,
and the source's history since then says what changed.
The commit is a hint and the date is the version:
a squash merge here retires the commits a branch carried, so a hash may stop resolving, while the date stays true and stays comparable.
The marker is also the backreference of every carried file, since a line edited into one is lost at the next update,
and its own first lines are a comment naming the local page.
The slug and URL it records default to this repository and can be overridden for a fork
through `HANDBOOK_SOURCE_SLUG` and `HANDBOOK_SOURCE_URL`.

**One script, four verbs.**
[`scripts/vendor.sh`](/scripts/vendor.sh) runs from a checkout of the source against a target.
The checkout is `$HANDBOOK_TOOLS` where that is set, else a sibling directory named `handbook-tools`, else a clone of the source.
`install` carries every class into a repository that has none of it and writes the marker.
`update` refreshes the pointer leaves and the tooling, names any stub that is absent without failing on it,
and stamps the marker with the source's state, which is what makes it the record of the last check.
`check` compares every carried file against the source at the commit the marker names:
`DRIFT` is a file edited in the target, `UPDATE` a file the source has changed since, and only the first is a finding.
It also reports a `MISSING` file or marker, and `BEHIND` where the marker's `source-date` is older than the source's,
and it exits non-zero on drift or on a missing file.
`diff` prints the drift as a patch that applies in a source checkout, which is how an edit found in a carried copy travels home.
Where the marker's commit no longer exists in the source, the source's head is the baseline and a `DRIFT` may be an update instead;
the script says so, and stamping from the source's default branch rather than from a branch about to be squashed avoids it.
A session runs the script through the `handbook-update` skill, and CI runs `check` from a checkout of this repository,
which is public and needs no token ([`checks/`](/handbook/checks/README.md)).

**What an adopting repository fills in.**
[`meta/local/`](/handbook/meta/local/README.md) answers the choices the shared pages leave open,
and states the rules a repository adopts beyond them; its stub lists the choices as run-in headings, so filling it in is answering them.
The glossary stub holds the repository's own terms, and names the glossary here for the system's, which it does not repeat.
The router stubs and the handbook root carry comments saying what to write in their place.
The ignore file names what the repository does not author, by kind and with a reason beside each line,
and it is where a repository that permits em dashes says so, since the check reports them by default.
A rule that turns out to be enforced in more than one repository moves from a local page to the shared page it belongs on.

**The way in from an earlier lineage.**
A repository whose `meta/` pages predate the shared ones converts them through the `handbook-adopt` skill,
which runs from a session with the source checked out beside the repository ([`agents/`](/handbook/agents/README.md)).
The old pages are read before the install replaces them with pointer leaves:
whatever they said that the shared pages do not, and that is still true, goes to the local page;
whatever they said that was an adaptation of the shared text to the repository's own words goes nowhere,
because the shared text now says it.
The repository's own areas, its glossary terms, its router's first five minutes, and its experiments are untouched by the install.
A rule file that restated the prose rules in the repository's own words is replaced by the shared one,
and a skill of the same name as a shared one is replaced too, so a repository that changed one carries the change here first.

**Mirrors are the repository's.**
A repository that copies skills and commands into `.github/` for a second agent copies the carried files itself after an update.
The script manages the `.claude/` side alone,
because a mirror is a per-tool rendering and which tools a repository serves is its own decision.
