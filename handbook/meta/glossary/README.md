# Glossary

The tree's recurring terms of art, one line each, every entry linking the leaf that owns the concept.
A term earns a line once a second leaf uses it, added by the change that reaches for it,
one line, so the register stays greppable and diffs per term.
The terms of the documentation system are defined here once, for every handbook built on it,
beside the terms of this repository's own machinery.

* **backreference**: the visible link a secondary document carries back to the handbook node it serves ([`meta/forms/`](/handbook/meta/forms/README.md)).
* **carried file**: a tooling file copied into a repository byte for byte and overwritten at its next update ([`adoption/`](/handbook/adoption/README.md)).
* **deepen line**: the italic last line naming what a not-yet-comprehensive leaf still owes ([`meta/forms/`](/handbook/meta/forms/README.md)).
* **depths** (reference, core, comprehensive): a leaf's three legitimate published states ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **derived document**: a page assembled from handbook leaves for reading, declaring them in a `derived_from:` list ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **entry**: what one change lands on a page, the shortest statement of its fact that is still correct ([`meta/authoring/`](/handbook/meta/authoring/README.md)).
* **experiment**: a dated directory recording a measurement too expensive to re-derive, cited by the leaf that leans on it ([`meta/experiments/`](/handbook/meta/experiments/README.md)).
* **growth move**: one of the five ways a change deepens the tree by one leaf ([`meta/growth/`](/handbook/meta/growth/README.md)).
* **leaf** / **internal node**: leaves explain, once; internal nodes navigate and may govern ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **local page**: the one page under `meta/` that states what this repository decides where the shared rules leave a choice open ([`meta/local/`](/handbook/meta/local/README.md)).
* **manifest**: the list of files the vendoring script carries into a repository, each with the class that says how ([`adoption/`](/handbook/adoption/README.md)).
* **marker**: `.handbook-source`, the file at a repository's root naming the source and the state of it the handbook was last checked against ([`adoption/`](/handbook/adoption/README.md)).
* **orphan**: a document outside the tree that neither derives from it nor backreferences it, or a record no leaf cites ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **pointer leaf**: a leaf that states and links its topic's canonical home elsewhere ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **principle**: a paragraph on an internal node that a leaf yet to be written could falsify, lives as long as the child list, and names no particulars ([`meta/forms/`](/handbook/meta/forms/README.md)).
* **scope sentence**: the sentence under a page's H1 that states its boundary, load-bearing at every depth ([`meta/forms/`](/handbook/meta/forms/README.md)).
* **secondary document**: any document outside `handbook/`; it derives from the tree or points into it ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **shared page**: a page whose one home is `cynkra/handbook-tools`, which every handbook built on it points to rather than copies ([`meta/`](/handbook/meta/README.md)).
* **status**: whether a page has been checked against reality, carried in front matter and orthogonal to depth ([`meta/handbook/`](/handbook/meta/handbook/README.md)).
* **stub**: a file the vendoring script installs once and never overwrites ([`adoption/`](/handbook/adoption/README.md)).
