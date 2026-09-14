# Style

How a sentence is written once it has earned its place:
the line break, the width, the full stop, the list, the number, the default, the example, the citation, and the link between leaves.
What earns a sentence, and how long an entry runs, is [`meta/authoring/`](/handbook/meta/authoring/README.md)'s.
This page has one home, [`cynkra/handbook-tools`](https://github.com/cynkra/handbook-tools):
every handbook built on it points here rather than carrying a copy, and a change to it lands here.
Read *this repository* as the one whose handbook brought you here, and `meta/local/` as its local page.

## Writing the sentence

* **Break lines at meaning boundaries** ([semantic line breaks](https://sembr.org)).
  A new line after each sentence, optionally after a clause that earns it, never inside a phrase.
  Widen a line rather than split a phrase, never leave a one-word line, and never start a line with one word and a comma.
* **Prose aims for 140 characters**, because a line much longer than that hides its own edits in a diff.
  Meaning wins where it will not fit, so a longer line is tolerated rather than corrected.
  A break moved to save characters is a break in the wrong place.
  A URL too long to break stands alone.
* **A comment says what the line does; the leaf says why, and the comment names it.**
  A comment arguing a design or recounting what went wrong before is a second copy of a leaf,
  and it is the copy nobody edits when the reasoning moves on.
* **A comment takes the code's budget, not the prose budget.**
  It aims for the line width the repository's formatter sets for the language it sits in
  ([`meta/local/`](/handbook/meta/local/README.md) names the formatter and the width).
  A comment shares its file with code held to that width, and a reader who sized a window for the code reads the comment in the same one.
  The number is a soft aim in exactly the way 140 is, and every other rule here holds there unchanged, the semantic break first of all.
  Holding it is the author's job, because a formatter reflows the code around a comment and leaves the prose inside it alone.
* **A line ends with a full stop**, and anything else wants a very good reason.
  A heading, a bold run-in, a list marker, and a colon introducing a list are the reasons, and there are few others.
  A line ending in a comma is the one to look at twice.
  It says the sentence outran the line, and two sentences almost always beat one clause break.
* **Default to a bullet list; make a table earn its columns.**
  A list extends one line at a time and diffs the same way, so an enumeration is bullets, each item led by its name.
  A table is for genuinely two-dimensional content, where the reader compares along both axes.
  A two-column table whose second column is prose is a list wearing borders.
* **State what stays true as the repository moves.**
  A number an ordinary commit invalidates is a hostage.
  Name the mechanism instead: the file that lists the members is durable where the count is not.
  A measurement stays when the text says it is one, and says what it was measured against.
  A count stays when it *is* the design rather than a tally of what happens to exist.
* **Treat a default as a fact.**
  A default governs behaviour, so name the value *and* where it is set.
  The page stays useful when the two drift apart.
* **Link a provisional fact to the issue or proposal that will change it.**
  Without the link a reader cannot tell "how it works" from "how it works for now".
  A behaviour that survives only because nobody has fixed it yet is documented as such, and stops being when the issue closes.
  Write the reference as a full link, `[#123](https://github.com/<owner>/<repository>/issues/123)`,
  with the angle brackets standing for this repository's slug.
  A bare `#123` becomes a link only in an issue or pull request body, in a comment, and in a commit message,
  and renders as plain text everywhere this repository keeps its prose.
* **Never refer by position: name the thing.**
  "The first two" breaks silently when the list above is reordered.
* **Illustrate with a placeholder or a named example, and label which.**
  A placeholder never goes stale but makes every reader substitute.
  A named example reads fluently but ages into a snapshot.
  Both are legitimate, and the guardrails are the same either way.
  Declare a placeholder scheme once, where it starts, and keep to one notation.
  A page running three is worse than either choice made badly.
  Say what a named example is a snapshot *of*, so a later reader treats it as history rather than as status.
  Refreshing it is then an ordinary edit, not a correction.
  A live inventory is neither.
  It *is* the fact, so it must be current, and a dated snapshot is exactly wrong for it.
* **Cite the claim, not its label.**
  An identifier from another page's numbering (a requirement number, an invariant number, a state number) means nothing where it is read.
  It resolves only for someone holding that table.
  Say what the requirement says, in the clause that depends on it.

## Linking between leaves

A link from one leaf to another is how the tree stays free of repetition.
It is also the tree's only maintenance cost that grows with its size.

**Link a boundary once per page, and link the owner.**
The load-bearing form is a page naming the boundary it does not own, stated once, where the reader first needs it.
A second link to the same target on the same page adds no reachability, and costs another edit when the target moves.
If a reader can enter mid-page and need it again, the page is too long, and splitting it is the fix.
Never link an internal node where one of its leaves owns the fact.
The node will look like an owner and collect citations its children deserve.

**A fact that moves takes its inbound links with it.**
Before changing where a fact lives (renaming a leaf, splitting one in two, moving a section), search the tree for what points at it.
Update those pages in the same change.
The links are one-directional, so nothing else will catch a stale one.
A leaf that has quietly become the wrong destination still resolves, and reads as if it were right, which is worse than a broken link.
The same search settles the cheaper question.
If nothing points at a leaf, its scope sentence is probably claiming a boundary no other page recognises.
