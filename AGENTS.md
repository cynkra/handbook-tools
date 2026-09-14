# AGENTS.md

Orienting doc for any AI coding agent landing in this repository.
Format: [agents.md](https://agents.md/).

_Everything this repository documents lives in [`handbook/`](/handbook/README.md), the single source of truth.
This page only routes there._

## What this repository is

The home of the documentation system that several repositories build on:
the shared pages under [`handbook/meta/`](/handbook/meta/README.md), which their handbooks point to,
and the rule file, the skills, and the check script, which they carry unchanged.
A change to a shared page here is read in every one of them the moment it lands, so a wording change is never cosmetic.

## The first five minutes

- where a fact lives, and how the tree grows: [`handbook/meta/handbook/`](/handbook/meta/handbook/README.md)
- how a sentence is written here, before you write one: [`handbook/meta/authoring/`](/handbook/meta/authoring/README.md)
- what this repository decides for itself, the em dash ban among it: [`handbook/meta/local/`](/handbook/meta/local/README.md)
- how a repository builds on the shared pages, and what the manifest's three classes mean:
  [`handbook/adoption/`](/handbook/adoption/README.md)
- what the check script reports, and how to run it: [`handbook/checks/`](/handbook/checks/README.md)
- how a change reaches this repository, and what a change to a shared file carries:
  [`handbook/contributing/`](/handbook/contributing/README.md)
- what is proposed and not yet done: [`plan/`](/plan/README.md)

## Behaviour

- Every document outside `handbook/` either derives from it or backreferences it, and this page's italic line is its own.
  In Claude Code the prose rules load on their own when you touch a file carrying prose.
  Run `/docs:check` after touching documentation, and `tests/run.sh` after touching a script.
- Never push to this repository from a session that reads other repositories.
  Work in progress goes to a private fork, and a pull request from it is opened only after every commit, every message,
  and the branch name have been checked for private material, and squashed where they carry any.
- Never push to `main`; a change lands through a pull request.
