#!/bin/sh
# The drift survey: how far the handbooks that existed before this repository
# had drifted from one another, and what the check script finds in each.
#
# Handbook: /handbook/adoption/README.md is what the findings support; the
# record beside this script says what was measured and when.
#
# Usage: survey.sh CLONES-DIR LIST > results.txt
#   CLONES-DIR holds a checkout of each surveyed repository.
#   LIST names them, one per line, as `label path flags`: the label is what
#   the results carry, the path is relative to CLONES-DIR, and the flags are
#   `em-dash` where the repository states the em dash ban, else `-`.
#   Two labels are the baselines the others are diffed against: `ancestor`,
#   the repository that wrote the rules first, and `template`, the one that
#   generalised them. The list is not committed, so that the results name
#   no repository.

set -u

clones=${1:?the directory holding the clones}
list=${2:?the list of repositories}
check=$(cd "$(dirname "$0")/../.." && pwd -P)/.claude/skills/docs-consistency/scripts/check-handbook.sh

# No surveyed repository carries an ignore file, so the survey supplies one:
# the exemptions the shared rules name for generated tooling, translated the
# same way for every repository, and nothing a repository would add itself.
ignore=$(mktemp "${TMPDIR:-/tmp}/survey-ignore.XXXXXX")
trap 'rm -f "$ignore"' EXIT INT TERM
cat >"$ignore" <<'IGNORE'
orphan: openspec/changes/
orphan: openspec/specs/
orphan: .claude/skills/openspec-*
orphan: .claude/commands/opsx/
orphan: .github/skills/openspec-*
orphan: .github/prompts/opsx-*
orphan: tests/testthat/_snaps/
orphan: revdep/
orphan: NEWS.md
em-dash: .claude/
em-dash: .github/skills/
em-dash: .github/prompts/
em-dash: node_modules/
em-dash: renv/
em-dash: revdep/
em-dash: man/
IGNORE

entries=$(sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$list")
path_of() { printf '%s\n' "$entries" | awk -v l="$1" '$1 == l { print $2; exit }'; }
ancestor=$clones/$(path_of ancestor)
template=$clones/$(path_of template)
pages='README.md handbook/README.md authoring/README.md experiments/README.md glossary/README.md'

changed() { # a b -> lines that differ, both sides counted
  if [ -f "$1" ] && [ -f "$2" ]; then diff "$1" "$2" | grep -c '^[<>]'; else echo n/a; fi
}

echo "== pages, and the shared pages' line counts"
printf '%-12s %6s %6s %6s %6s %6s %6s\n' repository pages meta rules author exper gloss
printf '%s\n' "$entries" | while read -r label rel flags; do
  d=$clones/$rel
  n=$(find "$d/handbook" -name '*.md' | wc -l | tr -d ' ')
  set -- "$n"
  for p in $pages; do
    f=$d/handbook/meta/$p
    if [ -f "$f" ]; then set -- "$@" "$(wc -l <"$f" | tr -d ' ')"; else set -- "$@" -; fi
  done
  printf '%-12s %6s %6s %6s %6s %6s %6s\n' "$label" "$@"
done

echo
echo "== lines differing from the ancestor's copy, and from the template's"
printf '%-12s %10s %10s %10s %10s %10s %10s\n' repository rules/anc rules/tpl auth/anc auth/tpl exp/anc exp/tpl
printf '%s\n' "$entries" | while read -r label rel flags; do
  d=$clones/$rel
  printf '%-12s %10s %10s %10s %10s %10s %10s\n' "$label" \
    "$(changed "$ancestor/handbook/meta/handbook/README.md" "$d/handbook/meta/handbook/README.md")" \
    "$(changed "$template/handbook/meta/handbook/README.md" "$d/handbook/meta/handbook/README.md")" \
    "$(changed "$ancestor/handbook/meta/authoring/README.md" "$d/handbook/meta/authoring/README.md")" \
    "$(changed "$template/handbook/meta/authoring/README.md" "$d/handbook/meta/authoring/README.md")" \
    "$(changed "$ancestor/handbook/meta/experiments/README.md" "$d/handbook/meta/experiments/README.md")" \
    "$(changed "$template/handbook/meta/experiments/README.md" "$d/handbook/meta/experiments/README.md")"
done

echo
echo "== the rule file and the skill, against the template's copy"
printf '%-12s %-14s %-14s\n' repository prose-rule docs-skill
printf '%s\n' "$entries" | while read -r label rel flags; do
  d=$clones/$rel
  a=$d/.claude/rules/prose-authoring.md
  b=$d/.claude/skills/docs-consistency/SKILL.md
  ra=absent; rb=absent
  [ -f "$a" ] && { cmp -s "$a" "$template/.claude/rules/prose-authoring.md" && ra=identical || ra="$(changed "$template/.claude/rules/prose-authoring.md" "$a") lines"; }
  [ -f "$b" ] && { cmp -s "$b" "$template/.claude/skills/docs-consistency/SKILL.md" && rb=identical || rb="$(changed "$template/.claude/skills/docs-consistency/SKILL.md" "$b") lines"; }
  printf '%-12s %-14s %-14s\n' "$label" "$ra" "$rb"
done

echo
echo "== what the check script finds today, by tag (the em-dash check where the repository states the ban)"
printf '%s\n' "$entries" | while read -r label rel flags; do
  d=$clones/$rel
  flag=
  case " $flags " in *" em-dash "*) flag= ;; *) flag=--no-em-dash ;; esac
  out=$(cd "$d" && "$check" --ignore-file "$ignore" $flag 2>&1)
  summary=$(printf '%s\n' "$out" | tail -1)
  tags=$(printf '%s\n' "$out" | awk '$1 ~ /^[A-Z-]+$/ { n[$1]++ } END { for (t in n) printf "%s=%d ", t, n[t] }' | tr ' ' '\n' | sort | tr '\n' ' ')
  printf '%-12s %s\n' "$label" "$summary"
  [ -n "$tags" ] && printf '%-12s   %s\n' '' "$tags"
done

exit 0
