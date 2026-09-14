---
name: handbook-adopt
description: Convert a handbook that already exists to build on cynkra/handbook-tools. Replace its copies of the shared meta pages with pointer leaves, carry the tooling in, move what the old pages said and the shared pages do not onto the local page, and leave the repository's own areas untouched. Use when a repository whose handbook predates the shared pages, or vendored copies of them, should point at the source instead.
license: MIT
compatibility: Requires git and a POSIX shell. Lives in the source only, and runs from a session in the repository to convert, which reads this file from a checkout of the source beside it (`$HANDBOOK_TOOLS`, else a sibling named `handbook-tools`), or from a session in the source against a sibling target.
---

# Handbook adopt

*Serves [`handbook/adoption/`](/handbook/adoption/README.md),
which owns the classes of carried file, the marker, and the way in from an earlier lineage,
and [`handbook/agents/`](/handbook/agents/README.md), which says what a repository ships for a session.*

A handbook that grew before the shared pages existed, or that carried copies of them, says the shared rules in its own words,
and those words drift.
The conversion replaces every copy with a pointer leaf at the same path, so that every link keeps resolving and the text lives once,
and keeps what the old pages said that the shared pages do not, on the one page that is the repository's own.
The order matters: the old pages are read first, because the install overwrites them, and git is the only copy afterwards.
Call the repository to convert `TARGET` and the source checkout `SOURCE`; both default to the current directory and its sibling.

## 1. Inventory

Before changing anything, list what the repository has, so that the report at the end can say what became of each:

* the pages under `handbook/meta/`:
  which of the six shared paths exist (`handbook`, `authoring`, `experiments`, `forms`, `growth`, `style`),
  which other children the index lists, and whether any carries `<!-- BEGIN LOCAL -->` markers or a `derived_from:` list;
* the router files `AGENTS.md` and `CLAUDE.md`, and whether either is a symlink;
* every rule file under `.claude/rules/`, with its `paths:`;
* every skill and command under `.claude/`, and any index of them (`.claude/README.md`), and the mirrors under `.github/` if any;
* the ignore files (`.handbook-ignore`, a prose-cleanup tool's, a linter's), and what each exempts;
* the CI workflows that run a documentation check, and what they run;
* an existing `.handbook-source` or any other marker of a previous adoption;
* the glossary and its terms, and the experiments registry.

Then read [`handbook/meta/local/`](/handbook/meta/local/README.md) in the source, as the example of a filled-in local page.

## 2. Read the old pages against the shared ones

For each of the six shared paths the repository has, diff its page against the source's:

```sh
diff -u "$TARGET/handbook/meta/handbook/README.md" "$SOURCE/handbook/meta/handbook/README.md"
```

Every paragraph the old page has and the shared page lacks goes to exactly one of four places, and the list is written down before step 3:

* **nowhere**, where it says what the shared page says in other words,
  or names a repository, a language, or a tool as an example of a shared rule;
* **the local page**, where it is a choice this repository made where the shared rules leave one open,
  or a rule this repository adopts beyond them: where intent lives, where evidence lives, what it does not author,
  the comment budget, the rules of its own, what ships without the tree, what enforces the checks;
* **the leaf that owns the topic**, where it is a fact about something other than the documentation system,
  which the old page carried because nothing else existed;
* **the source**, where it is a rule more than one repository enforces and the shared page lacks it;
  write it as a patch against the source, and open a pull request there separately.

A paragraph that contradicts the shared page is a decision for the user: the shared text wins unless they say otherwise,
and what they keep is a local rule, stated as such.

## 3. Install

```sh
"$SOURCE/scripts/vendor.sh" --source "$SOURCE" --target "$TARGET" install
```

The six pages become pointer leaves, the rule file, the skills, the check script, and the commands are carried in,
every stub whose path is free is installed, and the marker is written.
A stub whose path is taken, the `meta/` index, the glossary, the local page, the router files, the ignore file, the workflow,
is left alone, and step 4 converts each by hand.
An old marker is replaced; an old vendored copy of a skill with the same name as a carried one is replaced too,
and an edit it carried goes to the source as a patch, never back into the copy.

## 4. Convert what the install left alone

* **The `meta/` index** lists the six pointer leaves, the glossary, the local page, and the repository's own children,
  in alphabetical order,
  drops the local-region markers, and says that the shared pages point to their home rather than being carried;
  the source's stub at `stubs/handbook/meta/README.md` is the text to take.
* **The glossary** keeps the repository's own terms and drops the system's, which the source's glossary defines once;
  it names that glossary in one sentence, as the stub does, and drops the markers.
* **The local page** is filled from step 2's list, one run-in heading per choice, every rule linking the leaf that owns it,
  and its opening paragraph names the source and the marker, as the stub does.
* **The router files** keep the repository's first five minutes and prohibitions;
  their footer names the source and the marker, and a fact either carried is moved to its leaf.
* **A rule file that restated the prose rules** is deleted, since the carried one says them;
  a rule file that routes to the repository's own conventions stays,
  with its `paths:` narrowed so that the two do not both load on Markdown.
* **The skills index**, where one exists, says which skills are carried and which are the repository's own,
  and the mirrors under `.github/` are copied from the carried files by hand.
* **The ignore file** takes the exemptions the old checks had, by kind and with a reason beside each,
  and says whether em dashes are permitted; a second tool's ignore file stays until one absorbs the other.
* **The workflow** runs the check script and then, after a checkout of the source, the vendoring script's `check`,
  as the stub does; a sentence that said drift was checked by hand goes.
* **Links into a shared page's anchor** (`meta/handbook/#some-heading`) dangle now, because the pointer leaf has no such heading:
  link the page in the source with the anchor, or the pointer leaf without it.
* **A `derived_from:` list** that names a shared page keeps naming it; the pointer leaf stands for the page.

## 5. Check

Run, and fix what fires, until every one is clean:

```sh
"$TARGET/.claude/skills/docs-consistency/scripts/check-handbook.sh"
"$SOURCE/scripts/vendor.sh" --source "$SOURCE" --target "$TARGET" check
```

then the judgment half of the `docs-consistency` skill, and the repository's own checks: its formatter, its prose cleanup, its tests.

## 6. Report

* What was removed, in lines, and what each old paragraph became: nowhere, the local page, a leaf, or a patch for the source.
* What the reviewer reads first: the local page, then the `meta/` index, then the diff of the router files.
* What stays open: a contradiction the user decided, a patch proposed to the source, a mirror not yet copied.
* Never commit and never push unless asked: the user reviews and commits.
