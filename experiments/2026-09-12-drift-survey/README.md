# How far eleven handbooks drifted, and what the check script finds in each

*What it measures:* how far the shared pages under `meta/` differ between the eleven repositories that carried a handbook
before this repository existed, how many wordings of the prose rule file and the docs-consistency skill exist,
and what the check script written here reports in each tree.

*When and on what:* 2026-09-12, on each repository's default branch as cloned that morning.
The repositories are named in the results by lineage rather than by name:
`ancestor` wrote the rules first and has the largest tree; `copy` took them early and adapted them to a small repository;
`adapt-1` to `adapt-4` rewrote them around a specification store, in that order of age;
`template` generalised them and ships an update skill; `child-1` to `child-4` were generated from the template or adopted its pages by hand.
The check script as it stands in the commit this record was added in, with the em dash check on where the repository states the ban
(the ancestor and the four adaptations) and off elsewhere.
No repository carries an ignore file, so the survey supplies one, the same for every repository:
the exemptions the shared rules name for a specification store, generated test and dependency output, and vendored tooling,
listed in the script.
Method: [`survey.sh`](survey.sh), output in [`results.txt`](results.txt).
The list that maps each label to a repository is not committed, so that this record names none of them.

*What it supports:* the claim in [`adoption/`](/handbook/adoption/README.md)
that a copy of the shared pages drifts however carefully it is carried,
which is why a handbook points to them instead and only the tooling is copied, under a check that refuses drift,
and the lineage-by-lineage order in [`PLAN-consolidation.md`](/plan/PLAN-consolidation.md).

## Findings

**Five families of wording for the rules page, and six for the authoring page**,
judged by line count and by distance from the two baselines.
The rules page runs 300 lines in the ancestor, 233 in the copy, 180 in the oldest adaptation, 152 to 155 in the other three,
and 207 in the template and its four children.
Against the ancestor's copy, the template's differs in 419 lines, which is a rewrite, the adaptations' in 364 to 368,
and the copy's in 153, every count being both sides of the diff.
The five template-family copies are identical to one another except one child's, which differs in 12 lines.
The authoring page runs 192 lines in the ancestor and in one adaptation, 189 in two others, 171 in the copy,
162 in the template family, and 109 in the oldest adaptation.
The experiments page exists in nine of the eleven; the template's differs from the ancestor's in 51 lines,
and two adaptations replaced it with a stub of about twenty lines naming their own evidence directory.

**The rule file exists in five repositories, in two wordings; the skill in six, in four.**
`.claude/rules/prose-authoring.md` is identical in four of the five and differs in four lines in one child.
The docs-consistency skill is the template's in three, differs in ten lines in one child and in four in another,
and in the ancestor is a different document that shares no text with the others and drives two helpers of its own.

**No repository passes the check script clean; the template family comes closest.**
With the supplied exemptions, the template and three of its children each carry one orphan, and the fourth child seven.
The rest, with the em dash count where the repository states the ban, counted over every tracked text file:

* the ancestor: six orphans, and 1773 em dashes.
* the copy: one dangling link.
* `adapt-1`: five dangling links, one orphan, two em dashes.
* `adapt-2`: one experiment directory its registry does not name, and eight em dashes.
* `adapt-3`: four dangling links, one orphan, 2048 em dashes.
* `adapt-4`: one dangling link, eight internal nodes carrying a `##` heading, one orphan, 896 em dashes.

**The script changed during the survey**, twice after a finding the rules already excused, and the run recorded is the last:
it learned to skip a link inside an HTML comment and to take an index that names a file as that file's backreference,
and its built-in exemptions for one tool's directories became lines in an ignore file, which is what the survey now supplies.

## Replicating

Clone each repository into one directory, write the list the script's header describes, and run
`survey.sh <directory> <list> > results.txt` from anywhere inside this repository.
The check script findings will move with each repository's default branch.
The line counts and diffs will not, at the commits the clones stood at on the day named above.
