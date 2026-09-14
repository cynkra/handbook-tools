# Consolidating eleven handbooks onto one source

*A plan, not a description: it proposes how the repositories that grew their own copies of the handbook conventions
come to point here instead.
The conventions themselves are [`handbook/meta/`](/handbook/meta/README.md)'s, the mechanism is
[`adoption/`](/handbook/adoption/README.md)'s, and what was measured before writing this is
[`experiments/2026-09-12-drift-survey/`](/experiments/2026-09-12-drift-survey/README.md)'s.
No repository is named here or in that record; the lineage labels are the record's.*

## The situation

Eleven repositories carry a handbook in the same shape, 367 pages between them.
All descend from one ancestor, which wrote the rules first and still has the largest tree.
Three lineages grew from it:

* **The ancestor and its first copy.**
  The rules pages are the fullest.
  Enforcement is a link walker in Python plus an index generator in R in the ancestor,
  and a shell check inside the test suite of the copy.
* **The adaptations.**
  Four repositories rewrote the rules around a specification store and rules of their own.
  A prose-cleanup skill they vendor carries their em dash check,
  and their rule files route and trigger without restating a rule.
* **The template and its children.**
  The template generalised the rules away from any package, added six rules of its own, and ships an update skill.
  Three children were generated from it, and a fourth adopted its pages by hand, without the mirrors and with a symlinked router.

The survey found the four shared pages in five wordings, the prose rule file in two, the docs-consistency skill in four,
and no two lineages agreeing on where intent lives, whether em dashes are banned, or whether anything enforces the rules.
Every repository that bans em dashes carries them, by the hundreds in the ancestor.

## What this repository settles

* **One text for the shared pages**, generalised so that no repository, language, or tool is named on them,
  living here only, with a pointer leaf at each of their paths in every repository built on them.
  The rules page keeps the template's six additions, the ancestor's forms, and the adaptations' backreference cases.
  The authoring page keeps the ancestor's ladder and its paragraph on a behaviour that looks wrong,
  the template's generalisations, and the adaptations' refinements.
* **One local page for everything that differs**, so that the difference is stated once and the shared text never bends.
* **One check script** in POSIX shell, merging the ancestor's link and anchor checks, the copy's shape checks,
  and the template's derivation and orphan checks, run the same way by a session and by CI,
  with the exemptions a repository declares by kind in its ignore file rather than hard-coded for one tool.
* **One vendoring script with a manifest** for the little that is copied, the pointers and the tooling,
  so that a carried file can be checked for drift rather than trusted not to have any,
  a marker that records when the whole handbook was last checked against the source, by date because a squash merge retires the commit,
  and a `diff` verb that sends an edit home as a patch.
* **The em dash ban stays a local rule**, adopted by default in the local stub and checked by default,
  because the template declined to impose it and a repository that permits em dashes says so in one ignore-file line.

## The way in, lineage by lineage

Each step is one pull request per repository, driven by the `handbook-adopt` skill:
read the old pages, `scripts/vendor.sh --target <repository> install`, then the moves below, then `/docs:check` until it is clean.

1. **The template and its children.**
   The closest already.
   The four shared pages become pointer leaves; the template's extra child under `meta/` stays, listed in its index.
   The rule file and the docs-consistency skill are replaced by the shared ones, and `/docs:check` keeps its name.
   The local page records: intent in the change workflow and the tracker, evidence under `experiments/`,
   no em dash rule (or the adoption of it), and the CI workflow stub as enforcement, which none of them has today.
   The template's own update skill narrows to the template's own files and stops carrying the shared pages;
   its marker and `.handbook-source` coexist.
   The orphans the survey found under one child's migration plans are fixed on the way, by an index that names them.
   The template then ships the shared files to every new repository through this repository rather than its own copies.
2. **The ancestor.**
   The shared rules page loses the R-specific backreference cases; they move to the local page:
   the reader of the root `README.md` who arrives from a package tarball, the roxygen source as the generator,
   the rendered reference pages as auto-linked output, and the plan directory as the home of intent.
   Its extra child under `meta/` stays as a local one.
   The docs-consistency skill is replaced; the index generator stays as a repository-owned helper beside it
   until a portable generator exists, and the link walker is retired, its anchor check being in the shared script.
   The orphans and the em dashes the survey found are the repository's to work through, in passes of their own.
3. **The adaptations**, newest first, since the newest is the closest.
   The specification store is what the shared rule "a structured store mounts as a branch of the tree" describes,
   and "a handbook change carries no proposal" is now shared, so the local page keeps only the store's location and the workflow leaf.
   The rules they adopt beyond the shared ones, the em dash ban among them, go to the local page,
   each linking the leaf that owns it.
   The rule file that routed to the authoring leaf is replaced by the shared one; the one that routes to the package conventions stays,
   being the repository's own.
   The prose-cleanup skill stays vendored where it is, and its ignore file and `.handbook-ignore` coexist until one absorbs the other.
   One adaptation's leaf on skills already anticipated this move; its deepen line closes with it.
   The oldest adaptation carries the oldest variant and gains the most.
4. **The first copy.**
   Its shell check is replaced by a call to the shared script from the same test harness.
   Its rules page predates the ancestor's growth moves and forms; the shared page is a strict superset.

## Expansions proposed, and not yet done

* **A portable in-place index generator.**
  The ancestor's maps files to owning leaves and extracts headers, in R; a shell version reading its mapping from a file
  would let every repository generate the indexes the rules describe.
* **A staged-files mode** for the check script, so that a git hook can run the file-scoped checks on a commit,
  once a repository asks for one.
* **The prose-cleanup skill as a shared skill here**, or the shared script growing the judgment-free half of it,
  so that one ignore file serves both.

## Open questions

* Whether the em dash ban becomes shared. Six of eleven repositories state it, none holds to it, and the check now exists.
* When this repository goes public, since the design assumes it:
  a pointer leaf in a public repository links here, and its CI checks out this repository without a token.
* Whether the rule file also loads on source files, as one adaptation's does after review misses in comments,
  at the cost of loading on every edit.
* Whether the shared pages may keep naming R and its tooling as worked examples, as the experiments page does,
  or whether every such example moves to a local page.
