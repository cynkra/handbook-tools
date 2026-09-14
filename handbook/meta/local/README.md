# What this repository decides

The choices the shared rules ([`meta/handbook/`](/handbook/meta/handbook/README.md)) leave open, answered for this repository,
and the rules it adopts beyond the shared ones.
This is the one page under `meta/` that is this repository's own;
the pages beside it are the shared ones, and this repository *is* their source, so it carries no marker and nothing here is behind.

**Intent and status.**
Intent lives in [`plan/`](/plan/README.md): one `PLAN-<topic>.md` per open plan, and that file's index names every document there.
Status lives in the issue tracker.
A plan that has come true is documented as fact in the leaf that owns its topic, and the plan moves under `plan/done/`.

**Evidence.**
Measurements live under [`experiments/`](/experiments/README.md), in the shared shape, and the registry there names every record.

**What this repository does not author.**
Nothing here is generated.
[`tests/fixtures/`](/tests/fixtures/) holds deliberately broken handbook trees that the checks are tested against,
and [`.handbook-ignore`](/.handbook-ignore) keeps the checks out of them.

**The comment budget.**
The scripts are POSIX shell with no formatter, and a comment in one aims for 80 columns.

**Rules adopted beyond the shared ones.**

* **No em dashes**, in prose and code alike.
  A comma, a colon, a semicolon, or a parenthesis says the same thing.
  The check reports one in any tracked file, and a commit message is review's to read.

**Documents shipped without the tree.**
None: nothing here is packaged, so every secondary document links into the tree directly.

**Enforcement.**
[`.github/workflows/check.yaml`](/.github/workflows/check.yaml) runs the check script over this tree,
the script's own tests, and the manifest check, on every pull request.
