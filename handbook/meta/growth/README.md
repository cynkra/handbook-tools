# Growing a leaf

How the tree deepens: the five moves, any of which is a complete, mergeable pull request, and the protocol every move follows.
The rules a page obeys are [`meta/handbook/`](/handbook/meta/handbook/README.md)'s,
and the shapes a page takes are [`meta/forms/`](/handbook/meta/forms/README.md)'s.
This page has one home, [`cynkra/handbook-tools`](https://github.com/cynkra/handbook-tools):
every handbook built on it points here rather than carrying a copy, and a change to it lands here.
Read *this repository* as the one whose handbook brought you here, and `meta/local/` as its local page.

The tree deepens one leaf per change, by five moves.

1. **Close an issue into its leaf.**
   An issue closed without a code change is closed *with* a documentation change.
   The answer, workaround, or limitation lands in the leaf that owns the topic, and the closing comment links it.
   The leaf links the issue from the text that answers it.
2. **Absorb a document, or one section of one.**
   The fine print moves to the leaf in the same change.
   What stays behind is cut to what a reader standing there needs, and backreferences the leaf that now carries the detail.
   A source with nothing left worth keeping goes away entirely, and anything that linked to it is updated.
   The breadcrumb is the point: a fact that changes is edited in one place, and the reader who never heard of the handbook still finds it.
3. **Deepen from the ground truth.**
   Write what the code, the configuration, the scripts, and the workflows actually do, and cite the file that proves it.
4. **Give a homeless topic a home.**
   Something this repository carries that no leaf covers gets one, born at reference depth:
   a scope sentence, where the knowledge lives today, and a deepen line naming the rest.
   The node above gains a child-list entry, and a scope sentence too narrow to admit the new leaf is widened in the same change,
   because otherwise the next topic of that kind falls out again.
5. **Split a fact that has outgrown the page citing it.**
   Detail too large for the leaf that carries it becomes a leaf of its own beside that one, under the same node.
   The page it leaves keeps the shortest statement and the link ([`meta/authoring/`](/handbook/meta/authoring/README.md) says how short).
   In every other respect it is a new leaf:
   the node above gains its line in the child list, and the links pointing at the fact move with it.
   A page left holding nothing but pointers to what it gave away has become an internal node, and is written as one.

Whichever move, the same protocol:

* **Register a term the tree reuses.**
  A term of art gets a line in [`meta/glossary/`](/handbook/meta/glossary/README.md) linking its owning leaf,
  added by the change that coins it.
* **Follow the authoring pages.**
  Every sentence, new or absorbed, is walked down the ladder there before it is written.
  Absorption is rewriting, never blind copy-paste.
* **Stay inside the scope line.**
  A fact beyond it belongs to another leaf: link, don't absorb.
* **Finish clean.**
  Update the leaf's closing deepen line, or delete it when nothing remains, and leave no dangling links.
