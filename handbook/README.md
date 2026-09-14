# The handbook-tools handbook

The single source of truth for everything this repository documents;
internal pages like this one navigate and state their area's principles,
leaves explain ([`meta/handbook/`](/handbook/meta/handbook/README.md)).

This repository is the home of a documentation system that several repositories share:
the rules of a handbook tree, the prose rules, the evidence convention, the vocabulary of the system,
and the checks and the adoption that let another repository build on all of that without copying it.
The areas divide by what a question is about, not by who is asking it.
Someone writing a page in a repository built on the shared pages and someone changing a shared rule here
are served by the same tree, and the same question brings both to the same leaf.
What stays outside the tree, intent and evidence, and where each lives, is [`meta/local/`](/handbook/meta/local/README.md)'s.

* [`meta/`](meta/): the shared documentation system: the rules, the forms, the growth moves, authoring, style,
  the experiments convention, the glossary, and the local page
* [`adoption/`](adoption/): how a repository builds on the shared pages and keeps its handbook checked against them
* [`agents/`](agents/): what a repository ships for an AI session
* [`checks/`](checks/): what the check script reports, and how it is run
* [`contributing/`](contributing/): how a change reaches this repository, and what a change to a shared file carries
