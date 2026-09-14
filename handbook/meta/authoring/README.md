# Authoring

How prose is written here: what earns a sentence, and how long an entry runs, owned on this page in full.
The sentence itself, its line, its list, its numbers, and its links, is [`meta/style/`](/handbook/meta/style/README.md)'s.
Together they cover every Markdown file this repository authors, the handbook included,
and the comments in whatever code, configuration, and scripts it carries.
The tree's structure is [`meta/handbook/`](/handbook/meta/handbook/README.md)'s,
and its growth moves are [`meta/growth/`](/handbook/meta/growth/README.md)'s.
Extending the tree means following these pages.
This page has one home, [`cynkra/handbook-tools`](https://github.com/cynkra/handbook-tools):
every handbook built on it points here rather than carrying a copy, and a change to it lands here.
Read *this repository* as the one whose handbook brought you here, and `meta/local/` as its local page.

They stop in two places.
A GitHub issue or pull request body takes reflowed paragraphs instead, because a single newline renders there as a visible break.
Text this repository does not author is nobody's to reformat: generated files, and anything vendored or copied in from a third party.
Where a generated file's prose is wrong, the generator or its template is what gets edited.
Which files those are here is [`meta/local/`](/handbook/meta/local/README.md)'s.

A rule joins these pages once reviews in more than one repository have enforced it.
A rule one repository enforces is that repository's, and lives on its local page,
which is also where a repository adopts rules beyond these.
Until a rule is enforced it is a preference, and preferences are not enforced.

## Before writing a sentence

Walk these in order, and stop at the first that answers.
Only the two that ask whether it is a fact and whether it is true end in nothing being written, and what they discard is not a fact.
The rest move the fact somewhere better than a paragraph.

1. **Is it a fact about how things work today?**
   A failure narrative, before-and-after framing, a rejected alternative, where a file came from, or a design for work not done is none.
   All but the last are git's and the issues', and the last belongs where intent lives here, which the local page says.
2. **Is it true?**
   Verify against the thing itself: run the command, read the script, open the workflow log.
   A claim nobody checked reads exactly like one that was.
   When a claim is contested or surprising, check it before editing rather than after review does.
3. **Does another leaf, a file header, or a reference page own it?**
   Link it: never restate it, and never paraphrase it.
4. **Does an artifact already state it?**
   Never re-enumerate what a file lists, because the file is the list.
   Never exhaustively enumerate facts another leaf owns: state the principle that locates them, and stop.
   The inverse holds too: where a leaf is the list, no file outside the tree carries a second copy.
5. **Could a check state it instead?**
   A trap that keeps happening deserves a guard that refuses it, not a paragraph asking readers to remember.
   Where a guard is out of reach, the leaf gets the trigger and the action, never the anatomy.
   A behavioural claim lands with the test that pins it,
   and a claim about the shape of the repository graduates into the consistency checks.
   A choice too expensive to re-derive becomes a decision-log entry the leaf links, where the repository keeps a log.
   A measurement too expensive to re-derive becomes an experiment the leaf links
   ([`meta/experiments/`](/handbook/meta/experiments/README.md)).
   A derivation a reader could redo in a minute stays in the pull request.
6. **Then write it, as short as it can be and stay correct ([below](#how-long-an-entry-is)),
   and leave a breadcrumb where the reader stands.**
   When detail moves into a leaf, the source it came from (a document, a script header, an inline comment) keeps its essentials.
   The source also links the leaf that now carries the rest, so a fact is edited in one place and found from the place it is about.

**A behaviour that looks wrong rather than chosen is settled before the ladder, not on it.**
A fact can be true and still be one nobody should have to read, and no rung can tell which.
Nothing mechanical distinguishes a deliberate limitation from an unfixed one, because both are only what the code does.
So it is a discussion, not a test: is the behaviour *desirable*, or is it a mere *limitation*?
Desirable, and it is an ordinary fact, taking the ladder like any other.
A limitation, and the two costs are weighed against each other.
A fix of one to three lines, with consequences obvious enough to approve at a glance, is cheaper than the paragraph and every later edit.
Make it, and write nothing.
Anything larger is work carrying its own risk, review, and timeline, so the limitation is real for as long as that takes.
The tree requires the leaf to state its limits, with the issue that will remove it, so the fact reads as provisional.
Silence is the one answer never available.
A limitation nobody wrote down is one the next reader rediscovers, and pays for twice.

## Where the handbook stops

The rungs asking after another owner, an artifact, and a check all ask the same question: is something else a better home for this?
The answer generalises.
**The tree owns what the artifacts cannot say about themselves**, which is three things:

* **Why.**
  No file records why a dependency is vendored rather than fetched, or why status lives in a tracker rather than in a file here.
* **Across.**
  A relationship spanning files that no single one of them contains: an invariant, an ordering, the direction work is allowed to travel.
* **Not.**
  A limit, a declined request, an absence.
  Nothing in the code can say that an option is accepted and ignored, because the fact *is* the missing branch.

Everything else the artifact owns, and owns better:
what exists, how many there are, what the values are now, and what a mechanism does step by step.
Prose that enumerates goes stale without anyone noticing, because nothing fails when it does.
Which artifact that is differs by area, and the leaf is what says which:
a script or a workflow file, a reference page, a specification, a configuration file, the generator rather than its output.
Where an area has no such artifact, prose carries the weight alone.
That is why such facts are written out in full, in one place, and cited from everywhere that leans on them.

## How long an entry is

An **entry** (what one change lands on a page) is the shortest statement of its fact that is still correct.
Length is not thoroughness.
Three sentences where one would do leave the reader to find the one, and every later edit carries the other two.
Write the fact, what it means for the reader, and the link that supports it.
Then stop.
Short is not less true, because what the entry leaves out stays reachable in the source it links or the leaf it splits into.
An edit that loses a fact is a regression however short it reads.

**What supports a fact is not part of the fact,** and the pull to write the support out is strongest where the work was hardest.
Each source keeps what it is for:

* An **experiment** keeps the method, the full grid, and the day it was true of; the entry takes the finding and links the directory.
  A grid copied out of one is a second copy of a record that ages, and the leaf is the copy nobody re-runs.
* An **issue** keeps the report, the reproduction, and the discussion; the entry takes the answer.
  How the answer was reached is not part of it, and a limitation is one sentence and the issue that will remove it.
* A **proposal** keeps the design, its alternatives, and its sequencing;
  the entry takes what is true today, and links the proposal for the rest.
* A **decision log** keeps the context, the alternatives, and the date; the entry takes the consequence now in force.
  A rationale copied out of it is a second copy of a record nobody will ever edit again.

**Detail that survives all of that is a leaf, not a longer section.**
A fact needing more than a paragraph or two has outgrown the page that cites it.
Splitting it out is a growth move of its own.
The page that keeps the sentence and the link stays about one thing, which is what its scope sentence claims.
A page that absorbed three such facts instead can no longer say what it is about, and that, not the length, is the defect.

**A leaf past 120 lines owes an answer to why it is still one topic.**
Semantic line breaks put a sentence on a line, so 120 of them is a long stretch on one subject.
A leaf that long has usually grown a section a reader would look for under its own name.
The number asks the question rather than settling it.
A leaf that is genuinely one topic stays whole however long it runs.
One that is not splits at the heading that could stand alone, which is the growth move rather than an edit.
Compressing to get under the number is the wrong move in both cases, because sentences cut to fit lose facts that a split keeps.
