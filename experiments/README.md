# `experiments/`: measured evidence

*Handbook: [`meta/experiments/`](/handbook/meta/experiments/README.md) owns this directory's conventions.*

One directory per experiment, holding everything it needs:
a `README.md` that says what was measured, when, on what, and which handbook leaf relies on it,
plus whatever the run took: scripts, inputs, recorded output.

This file is what names the contents, so nothing here is an orphan.
The change that adds a directory adds its line below: the name, what it measured, and the leaf it supports.

* [`2026-09-12-drift-survey/`](2026-09-12-drift-survey/): how far the eleven handbooks that existed before this repository had drifted
  from one another, page by page, and what the check script finds in each;
  supports [`adoption/`](/handbook/adoption/README.md).
