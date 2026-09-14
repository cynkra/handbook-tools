# The handbook's rules

The handbook is a strict topic hierarchy with full cover:
every aspect of this repository that may need documentation has exactly one place in this tree.
These rules say what a page must do.
The shapes the tree has settled on for doing it are [`meta/forms/`](/handbook/meta/forms/README.md)'s,
the moves that deepen it are [`meta/growth/`](/handbook/meta/growth/README.md)'s,
and how the prose itself is written is [`meta/authoring/`](/handbook/meta/authoring/README.md)'s.
This page has one home, [`cynkra/handbook-tools`](https://github.com/cynkra/handbook-tools):
every handbook built on it points here rather than carrying a copy, and a change to it lands here.
Read *this repository* as the one whose handbook brought you here, and `meta/local/` as its local page.
What this repository decides for itself, where these rules leave a choice open, is [`meta/local/`](/handbook/meta/local/README.md)'s.

* **Internal nodes navigate, and may govern.**
  An internal `README.md` is a scope sentence, optionally the principles that govern its area, and a nested list of its subdirectories,
  and, except at the root, nothing else.
  A principle is why the area is divided as it is, or a constraint every leaf under it obeys.
  It belongs to the node because no single leaf could state it without reaching past its own scope.
  Anything one leaf could state is that leaf's, and an internal node never repeats it.
  The root's child list additionally sketches each area's contents in prose, naming the next level rather than linking it,
  so the sketch cannot rot.
* **Leaves explain, once.**
  A leaf owns its topic; every other page links to it and never paraphrases it.
  Documentation rots by duplication: a fact living in three files is updated in one while the other two silently start lying.
  So one fact, one page is the fix, and the fix is structural rather than disciplinary.
  A leaf may sit at any depth, including directly under the root.
* **Leaves own their boundaries.**
  A leaf states not only how its topic works but also its limits and its declined requests with their reasons.
  Where intent exists, the leaf points to the proposal or issue that carries it.
  "Can it do X?" is answered at X's leaf, whichever way the answer goes.
* **Full cover.**
  Every fact is reachable by walking down from [`handbook/`](/handbook/README.md).
  A topic with no place in the tree is a defect of the tree, not of the topic.
  Nothing announces such a defect, because a homeless topic raises no error and is simply absent,
  so full cover is a claim the tree has to be audited against, not one its shape can enforce.
* **A scope sentence states a boundary, not a child list.**
  A node that describes itself by naming what is under it cannot admit the topic it did not foresee.
  The wording excludes it, and nobody notices, because the child list below says the same thing and agrees.
  So when a topic turns out to have no home, ask first whether a node's *wording* excluded it rather than its design.
  That is the cheaper defect, and the commoner one.
* **Names are paths, not positions.**
  A living page is never numbered (`01-vocabulary.md`).
  Order is a fact, and it already has a home in the list that sequences the pages.
  A numbered filename stores that fact a second time, where only a rename can update it, and a rename rots every inbound link.
  Number, or better date-stamp, only append-only artifacts whose identity is assigned once and never reordered:
  archived changes, log entries, snapshots, experiment records.
* **Pointer leaves are legitimate.**
  The canonical home is sometimes elsewhere:
  a reference page shipped with the software, a machine-loaded skill under `.claude/skills/`,
  a tool's own documentation, an external standard.
  There the leaf states where the fact lives and links it, so a traversal still finds it.
  The tree needs no separate map of what lives outside it; the leaves are the map.
* **Intent lives outside the tree.**
  A proposal describes work that is not done; the handbook describes how things work today.
  So intent stays out of `handbook/`, and status stays with it: a decision taken, not a leftover.
  Where the two live here, a plan directory, a change workflow, an issue tracker, is the local page's.
  Each affected leaf links the proposal or issue that carries its intent,
  and a proposal that has become fact is documented as fact, in the leaf, with no trace of its having once been a proposal.
  A change that touches only the handbook carries no proposal:
  the tree describes, and a description that needed one would turn every documentation edit into a change of intent.
* **Evidence lives outside the tree.**
  A measurement, a benchmark, or a survey result too expensive to re-derive is a record rather than a fact.
  It lives in a dated directory of its own, with the method that produced it, and it is never edited to match a later day.
  The leaf that leans on it takes the finding and links the record.
  [`meta/experiments/`](/handbook/meta/experiments/README.md) owns what earns a record and the shape one takes.
* **The tree is the single source of truth.**
  Everything outside it is secondary:
  the root `README.md`, the agent router files, skills and commands, script headers, per-directory indexes, convenience copies.
  Every secondary document either derives from the tree or carries a backreference to the handbook node it serves.
  Where a pointer leaf names a fixed home for a fact, the links are bidirectional:
  the leaf points at the home, and the home backreferences the leaf.
  A document with neither is an orphan.
  Three kinds are exempt: intent and work in progress, whatever a run captured beside an experiment record's `README.md`,
  and anything a tool outside this repository generates,
  because a backreference edited into generated output would not survive the next regeneration.
  Which paths those are here is recorded in the repository's ignore file, beside the reason for each, where the checks read it.
* **A role is not a duplicate.**
  Commitments, status, history, and facts are four separate roles, and each has exactly one home.
  Status usually lives outside the repository, in its issue tracker, and history lives in the logs: a changelog, a decision log, git.
  A deadline can be a commitment in a charter and a milestone in the tracker; that is role separation.
  Each of them still points at the leaf holding the detail, and anything without such a role lives in the tree, once.
* **Logs are exempt from deduplication.**
  A log entry is a snapshot.
  It repeats facts as they stood on its date, and editing it when they change would destroy the record it exists to be.
  A durable lesson inside an entry is promoted onto the leaf that owns the topic, and the entry stays behind as history.
* **A structured store mounts as a branch of the tree.**
  Some facts live in a store another tool owns and changes only through its own workflow:
  requirements under a specification directory, a schema, an inventory a tool maintains.
  The node above it gains one child-list entry, so a reader asking what the repository must deliver is routed there like anywhere else.
  An entry's only home is its store: a leaf links it and never restates it,
  and rationale that outgrows a sentence stays on the leaf the store points back to.
* **A derived document declares its sources.**
  A derived document is a how-to, a checklist, a rule file an agent loads,
  or any page that re-sequences facts for reading rather than for maintenance.
  It lists the leaves it was built from in `derived_from:` front matter,
  or in an HTML comment where the front matter belongs to another tool, and it is refreshed when they move on.
  Forward references are stored and reverse references are computed:
  a "derived by" list on a leaf would rot, so the checks find the affected documents by comparing last-commit times instead.
  Derivation runs one way, so a wrong derived document is fixed at its leaf first and re-derived after.
  Two grades are legitimate.
  *Editorial* is the default, where the sources are re-read and the document rewritten.
  *Mechanical* is where a script assembles it, which is where a fact inlined in several derived documents belongs.
  What a derived document is *for* is the reader, and [Diátaxis](https://diataxis.fr/) is the vocabulary for that:
  a tutorial or a how-to guide is derived almost by definition, because it sequences facts into a path,
  and reader-facing reference and explanation are derived whenever readability wants what the tree forbids.
  Duplication is a defect upstream of derivation and a rendering choice downstream of it.
  A small tree doubles as its own reference.
  While the readers are the people maintaining it, derive only what a reader outside that group needs.
* **Status is orthogonal to depth.**
  Depth is how much of a topic is written.
  Status is whether what is written has been checked against reality, and neither implies the other.
  Front matter carries the status: `status: draft` marks a page captured, plausible, and unverified,
  and `status: confirmed` with `verified: YYYY-MM-DD` replaces it once someone has checked the page against the thing itself.
  Capture in place: an ad-hoc list or script goes straight to its final location marked draft,
  because a scratch area would recreate the duplication problem.
  Promotion flips the field after verification; it is never a copy or a move.
  Pages without a status field are settled prose where the distinction adds nothing.
* **A leaf is born small and grows in place.**
  Three depths are legitimate published states.
  A **reference** leaf states its scope and where the knowledge lives today.
  A **core** leaf adds the load-bearing facts, the defaults, the boundaries, the answers questions keep asking for,
  and still points elsewhere for the rest.
  A **comprehensive** leaf answers its topic in full, so a reader never has to leave the tree for it.
  Comprehensive is the end state, not the entry bar,
  and a leaf below it says what remains in one closing line, the deepen line, which is this tree's only form of visible debt.
  Splitting comes late, when a page has accreted facts that change for different reasons.
  A move is a rename, and a premature hierarchy is navigation tax.

## Enforcement

Consistency is agent work.
The checks are the `docs-consistency` skill's, which is the list, and its script is the mechanical half,
whatever a string comparison can answer, so that a session and CI run the same checks and see the same findings.
The judgment is the reading around them:
whether a topic is homeless, whether a scope sentence still admits its children, whether an entry restates what it links,
whether a document that merely points should be derived.
The rules define and the skill enforces, so when the two disagree this page is the authority, and the fix lands here first.
Whether the script runs on every pull request here, or by hand alone, is the local page's.
