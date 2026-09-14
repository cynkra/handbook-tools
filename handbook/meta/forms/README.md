# The forms

The shapes the tree has settled on, so that leaves written independently read as one document:
what a leaf, a link, a deepen line, a principle, an absorbed file, and a backreference look like.
The rules they serve are [`meta/handbook/`](/handbook/meta/handbook/README.md)'s,
and how the prose inside them is written is [`meta/authoring/`](/handbook/meta/authoring/README.md)'s.
This page has one home, [`cynkra/handbook-tools`](https://github.com/cynkra/handbook-tools):
every handbook built on it points here rather than carrying a copy, and a change to it lands here.
Read *this repository* as the one whose handbook brought you here, and `meta/local/` as its local page.

**A written leaf** opens with its H1, then a scope sentence in ordinary prose, then the content.
The scope sentence is load-bearing at every depth, because the tree's shape depends on every leaf declaring its boundary.
A one-screen leaf needs no headings; a longer one uses `##`.

**A named part of a one-screen leaf** opens with a bold run-in phrase rather than a heading.
Headings start where a page is long enough to navigate.

**A link to a handbook page** names the directory in backticks and targets its `README.md`.
An internal node's child list is the exception:
there the link text is the directory and so is the target, because the list is the tree rather than a citation.

**A link that leaves its own directory is written from the repository root**, with a leading `/`.
Same-directory and downward links stay relative, and an upward `../` chain is never written.
Such a chain breaks the moment a page moves, and a page in a settling tree moves.
GitHub resolves a root-relative link on any branch or fork; a local Markdown preview does not, and that is the trade taken.

**A deepen line** is the last line of a leaf that is not yet comprehensive:
one italic sentence naming what deepening absorbs, verifies, or drains,
kept current by every change to the leaf, and deleted by the change that completes it.
An example is `*To deepen: absorb the script's header comment; drain #12.*`.
A leaf with no deepen line asserts it is comprehensive.

**A principle on an internal node** is a short paragraph, or a few, between the scope sentence and the list of children.
It survives three tests, and a sentence that fails any of them belongs to a leaf instead:
a leaf yet to be written could falsify it (a generalisation over the children, not a summary of one);
it has the lifetime of the child list (a fact an ordinary commit could falsify has a leaf);
and it names no particulars: no paths, scripts, variables, versions, counts, or commands.
A node whose leaves share no such constraint gets no principle, and a node never restates a rule that a leaf under it owns.

**An absorbed file keeps its essentials, or goes away.**
A file whose detail has landed in a leaf shrinks to the part its own readers need and backreferences that leaf.
What it must not become is a one-line redirect.
A file only partly absorbed keeps its remaining sections, and each absorbed heading becomes a one-line pointer to the leaf.
A file with nothing left worth keeping is deleted, and everything that linked to it is updated in the same change.
Its place in a directory of scripts or records is taken by an **in-place `README.md`**, the index GitHub renders when someone browses there:
one row per file, grouped by the handbook leaf that owns each file's topic, written by hand or generated from the files' own headers.
Where it is generated, the generator's file-to-leaf mapping is what a change edits, never the rendered table.
One directory never gets an in-place index: a `.github/README.md` would be surfaced as the repository front page.

**A backreference is how a leaf is found by someone who does not know the handbook exists.**
Someone standing in a directory of scripts finds the leaf that explains what they are looking at.
An in-place index carries the backreference for every file it names, and where no index names a document, it carries its own:

* *Markdown* takes a visible italic line directly under the H1, linking the leaf by root-relative path.
  Several leaves serving one file share the one line.
  It becomes a footer line, or a pointer inside a documentation section,
  where the file's readers arrive from elsewhere and a line above the first sentence would interrupt them;
  the root `README.md` is the usual case.
* *Source files, scripts, and configuration* take a plain comment in their own syntax, in the header or beside the block it explains.
  A reference page shipped to readers who do not have the tree never links into it,
  because the link would be broken for them;
  the comment sits beside the documentation block rather than inside it.
* *Generated files* take theirs in the generator, in the template the file is rendered from, so that it survives the next regeneration.
  Editing the output to add one is writing in sand.
* *A directory of vendored files* takes one `README.md` index instead of a line per file,
  because a line added to a vendored file is lost at its next bump.
