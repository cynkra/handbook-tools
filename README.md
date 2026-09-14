# handbook-tools

*One fact, one home: the documentation system several repositories share, kept in one place and pointed to from every handbook built on it.*

The shared pages under `handbook/meta/` are the rules of a handbook tree, the shapes and growth moves of its pages,
the prose rules, the evidence convention, and the vocabulary of the system.
A handbook built on them carries a one-paragraph pointer leaf at each of their paths, and reads the pages here.
Beside them sit a path-scoped rule file and two skills for an AI session, a check script,
and a vendoring script that carries the pointers and the tooling into a repository, refuses a carried copy that drifts,
and stamps when the whole handbook was last checked against this one.

_This page is a tour, not a home for facts:
everything it says is documented in [`handbook/`](/handbook/README.md), and every document outside that tree, this one included,
either derives from it or points into it._

## Why one source

The handbook conventions grew in one repository, were copied into others, and drifted:
the same pages ended up in several wordings, a rule fixed in one place stayed broken in the rest,
and a rule file that restated the pages restated a different version in each.
The fix is structural.
The shared pages have one home and no copies: every repository points here, and reads the latest text the moment it lands.
The little that must be copied, a rule file and the skills, is carried by a script that refuses a copy that differs.
What a repository decides for itself has one page too, so that the difference is stated once and the shared text never bends to it,
and a marker records which state of this repository that page was last checked against.

## Adopting it

From a checkout of this repository, against the repository that should adopt it:

```sh
scripts/vendor.sh --target ../my-repo install
```

Then fill in what the stubs ask for, starting with `handbook/meta/local/`, and run the checks:

```sh
.claude/skills/docs-consistency/scripts/check-handbook.sh
```

What `install`, `update`, `check`, and `diff` do, what is carried and what stays the repository's own,
and the way in for a handbook that predates the shared pages are [`handbook/adoption/`](/handbook/adoption/README.md)'s.
Inside a session, `/handbook:update` and `/docs:check` drive the same two scripts,
and the `handbook-adopt` skill here converts a handbook that already exists.

## What is inside

- [`handbook/`](/handbook/README.md): this repository's own handbook, whose `meta/` pages are the shared ones.
- [`scripts/`](/scripts/manifest): the manifest and the vendoring script.
- [`pointers/`](/pointers/handbook/meta/handbook/README.md): the pointer leaves an adopting repository carries at the shared pages' paths.
- [`stubs/`](/stubs/): the files installed once into an adopting repository.
- [`.claude/`](/.claude/): the rule file, the skills with the check script, and the commands;
  all carried into adopting repositories but the adoption skill, which runs from here.
- [`tests/`](/tests/run.sh): the scripts run against a tree with every kind of finding, a clean one, and a fresh adoption.
- [`experiments/`](/experiments/README.md) and [`plan/`](/plan/README.md): the evidence behind the design, and the intent not yet done.

A change to a shared page is read in every repository built on it the moment it lands;
what it carries, and how work in progress stays off this repository, is [`handbook/contributing/`](/handbook/contributing/README.md)'s.
