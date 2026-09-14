#!/bin/sh
# Tests for the check script and the vendoring script, against the fixtures
# beside this file: a tree with one of every finding, a tree with none, and
# an empty repository that adopts the shared files from a snapshot of this
# repository.
#
# Handbook: /handbook/checks/README.md owns what the findings mean, and
# /handbook/adoption/README.md owns what install, update, check and diff do.
#
# Exit status: 0 when every expectation held, 1 otherwise.

set -u

here=$(cd "$(dirname "$0")" && pwd -P)
source=$(cd "$here/.." && pwd -P)
check=$source/.claude/skills/docs-consistency/scripts/check-handbook.sh

tmp=$(mktemp -d "${TMPDIR:-/tmp}/handbook-tests.XXXXXX") || exit 1
trap 'rm -rf "$tmp"' EXIT INT TERM
fail=0

ok() { echo "ok   $1"; }
bad() { echo "FAIL $1"; fail=1; }

git_() { git -c user.name=tests -c user.email=tests@example.invalid "$@"; }
commit() { # dir message
  GIT_AUTHOR_DATE=2020-01-01T00:00:00Z GIT_COMMITTER_DATE=2020-01-01T00:00:00Z \
    git_ -C "$1" commit -q --allow-empty -m "$2"
}

# A fixture becomes a repository with one commit, dated in the past so that a
# file edited afterwards is unambiguously newer than the commit.
setup() {
  rm -rf "$tmp/repo"
  mkdir -p "$tmp/repo"
  [ -d "$here/fixtures/$1" ] && cp -R "$here/fixtures/$1/." "$tmp/repo/"
  [ -f "$tmp/repo/gitignore" ] && mv "$tmp/repo/gitignore" "$tmp/repo/.gitignore"
  git_ -C "$tmp/repo" init -q
  git_ -C "$tmp/repo" add -A
  commit "$tmp/repo" fixture
}

# The vendoring tests run against a snapshot of this repository with its
# working tree committed, so that the baseline the check compares against is
# what install carried, whatever the real working tree looks like.
snapshot_source() {
  rm -rf "$tmp/src"
  cp -R "$source" "$tmp/src"
  git_ -C "$tmp/src" add -A
  commit "$tmp/src" snapshot
}
vendor="$source/scripts/vendor.sh"

# --- the broken tree reports one of everything -----------------------------

setup broken
printf '\nEdited after the derivation.\n' >>"$tmp/repo/handbook/alpha/README.md"
if (cd "$tmp/repo" && "$check" >"$tmp/out" 2>&1); then
  bad "broken tree: expected findings, got a clean run"
else
  ok "broken tree: exits non-zero"
fi
awk '$1 ~ /^[A-Z-]+$/ && NF >= 2 { p = $2; sub(/:[0-9]+$/, "", p); print $1, p }' "$tmp/out" | sort >"$tmp/got"
sort "$here/fixtures/broken.expected" >"$tmp/want"
if diff -u "$tmp/want" "$tmp/got" >"$tmp/diff"; then
  ok "broken tree: every expected finding, and no other"
else
  bad "broken tree: findings differ from fixtures/broken.expected"
  cat "$tmp/diff"
  echo "--- full output"
  cat "$tmp/out"
fi
if (cd "$tmp/repo" && "$check" --no-em-dash 2>&1 | grep -q '^EM-DASH'); then
  bad "broken tree: --no-em-dash still reports an em dash"
else
  ok "broken tree: --no-em-dash drops the em dash check"
fi
if (cd "$tmp/repo" && "$check" bogus >/dev/null 2>&1); then
  bad "broken tree: an unknown check name was accepted"
else
  ok "broken tree: an unknown check name is a usage error"
fi

# --- the clean tree reports nothing ----------------------------------------

setup clean
if (cd "$tmp/repo" && "$check" >"$tmp/out" 2>&1); then
  ok "clean tree: clean"
else
  bad "clean tree: unexpected findings"
  cat "$tmp/out"
fi
if (cd "$tmp/repo" && "$check" board | grep -q 'handbook/one/README.md .* open$'); then
  ok "clean tree: the board reports the open deepen line"
else
  bad "clean tree: the board does not report the deepen line"
fi

# --- the source checks its own manifest ------------------------------------

if "$vendor" --target "$source" check >"$tmp/out" 2>&1; then
  ok "source: the manifest names files that exist"
else
  bad "source: the manifest names a file that does not exist"
  cat "$tmp/out"
fi

# --- an empty repository adopts the shared files and passes the checks -----

snapshot_source
setup none
if "$vendor" --source "$tmp/src" --target "$tmp/repo" install >"$tmp/out" 2>&1; then
  ok "install: carries the files into an empty repository"
else
  bad "install: failed"
  cat "$tmp/out"
fi
for f in .handbook-source handbook/meta/handbook/README.md handbook/meta/README.md handbook/meta/glossary/README.md \
  handbook/meta/local/README.md .claude/rules/prose-authoring.md AGENTS.md .handbook-ignore; do
  [ -f "$tmp/repo/$f" ] || bad "install: $f missing afterwards"
done
if grep -q '^commit: ' "$tmp/repo/.handbook-source" &&
  grep -qE '^source-date: [0-9]{4}-[0-9]{2}-[0-9]{2}$' "$tmp/repo/.handbook-source" &&
  grep -qE '^checked: [0-9]{4}-[0-9]{2}-[0-9]{2}$' "$tmp/repo/.handbook-source" &&
  grep -q '^  - handbook/meta/handbook/README.md$' "$tmp/repo/.handbook-source" &&
  ! grep -q '^  - AGENTS.md$' "$tmp/repo/.handbook-source"; then
  ok "install: the marker names the commit, its date, the day of the check, and the carried files"
else
  bad "install: the marker lacks the commit, a date, or the file list, or lists a stub"
  cat "$tmp/repo/.handbook-source"
fi
if grep -q 'blob/main/handbook/meta/handbook/README.md' "$tmp/repo/handbook/meta/handbook/README.md" &&
  ! cmp -s "$tmp/repo/handbook/meta/handbook/README.md" "$tmp/src/handbook/meta/handbook/README.md" &&
  [ "$(wc -l <"$tmp/repo/handbook/meta/handbook/README.md")" -lt 12 ]; then
  ok "install: a shared page arrives as a pointer leaf, not as a copy"
else
  bad "install: the shared page was copied, or the pointer does not link its home"
fi
if ! grep -q 'BEGIN LOCAL' "$tmp/repo/handbook/meta/glossary/README.md" &&
  ! grep -q '^\* \*\*scope sentence' "$tmp/repo/handbook/meta/glossary/README.md"; then
  ok "install: the glossary stub carries no system terms and no markers"
else
  bad "install: the glossary stub carried the source's terms or the old markers"
fi
if (cd "$tmp/repo" && "$check" >"$tmp/out" 2>&1); then
  ok "install: the adopted tree passes the checks"
else
  bad "install: the adopted tree has findings"
  cat "$tmp/out"
fi
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check >"$tmp/out" 2>&1; then
  ok "check: clean right after install"
else
  bad "check: findings right after install"
  cat "$tmp/out"
fi

# --- a declined stub, an edited copy, and a source change ------------------

rm -f "$tmp/repo/CLAUDE.md"
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check >/dev/null 2>&1; then
  ok "check: a declined stub is not a finding"
else
  bad "check: a declined stub failed the check"
fi
printf '\nAn edit made in the carried copy.\n' >>"$tmp/repo/.claude/commands/docs/check.md"
printf '\nAn edit made in the pointer leaf.\n' >>"$tmp/repo/handbook/meta/handbook/README.md"
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check >"$tmp/out" 2>&1; then
  bad "check: an edited carried file was not reported"
else
  if grep -q '^DRIFT .*\.claude/commands/docs/check.md' "$tmp/out" && grep -q '^DRIFT .*handbook/meta/handbook/README.md' "$tmp/out"; then
    ok "check: an edited carried file and an edited pointer leaf are DRIFT"
  else
    bad "check: exit non-zero, but no DRIFT line for the edited files"
    cat "$tmp/out"
  fi
fi
if "$vendor" --source "$tmp/src" --target "$tmp/repo" diff 2>/dev/null | grep -q '^+An edit made in the carried copy'; then
  ok "diff: the drift prints as a patch"
else
  bad "diff: the drift did not print as a patch"
fi
"$vendor" --source "$tmp/src" --target "$tmp/repo" update >/dev/null 2>&1
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check >/dev/null 2>&1 &&
  ! grep -q 'An edit made' "$tmp/repo/handbook/meta/handbook/README.md"; then
  ok "update: refreshes the edited files"
else
  bad "update: the edited files were not refreshed"
fi

printf '\nA sentence the source added later.\n' >>"$tmp/src/.claude/commands/docs/check.md"
printf '\nA sentence the source added to a shared page.\n' >>"$tmp/src/handbook/meta/experiments/README.md"
git_ -C "$tmp/src" add -A
commit "$tmp/src" "a later change"
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check >"$tmp/out" 2>&1; then
  if grep -q '^UPDATE .*\.claude/commands/docs/check.md' "$tmp/out" && ! grep -q 'experiments' "$tmp/out"; then
    ok "check: a source change to a carried file is UPDATE, to a shared page nothing, and clean"
  else
    bad "check: clean, but the UPDATE lines are not the expected ones"
    cat "$tmp/out"
  fi
else
  bad "check: a source change was reported as a finding"
  cat "$tmp/out"
fi
sed 's/^source-date: .*/source-date: 2019-01-01/' "$tmp/repo/.handbook-source" >"$tmp/marker" && mv "$tmp/marker" "$tmp/repo/.handbook-source"
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check 2>/dev/null | grep -q '^BEHIND'; then
  ok "check: an older source-date is BEHIND"
else
  bad "check: an older source-date was not reported"
fi
mv "$tmp/repo/.handbook-source" "$tmp/marker"
if "$vendor" --source "$tmp/src" --target "$tmp/repo" check >"$tmp/out" 2>&1; then
  bad "check: a missing marker was not a finding"
else
  grep -q '^MISSING .*\.handbook-source' "$tmp/out" && ok "check: a missing marker is MISSING" || { bad "check: exit non-zero without a MISSING marker line"; cat "$tmp/out"; }
fi
mv "$tmp/marker" "$tmp/repo/.handbook-source"

# --- an older handbook is converted: copies become pointers, own files stay -

setup none
mkdir -p "$tmp/repo/handbook/meta/handbook" "$tmp/repo/handbook/meta/glossary"
printf '# The rules\n\nAn older wording of the shared rules.\n' >"$tmp/repo/handbook/meta/handbook/README.md"
printf '# Glossary\n\n* **own term**: a term this repository defined.\n' >"$tmp/repo/handbook/meta/glossary/README.md"
if "$vendor" --source "$tmp/src" --target "$tmp/repo" install >"$tmp/out" 2>&1 &&
  grep -q 'blob/main' "$tmp/repo/handbook/meta/handbook/README.md" &&
  ! grep -q 'older wording' "$tmp/repo/handbook/meta/handbook/README.md" &&
  grep -q 'own term' "$tmp/repo/handbook/meta/glossary/README.md"; then
  ok "install: an old copy of a shared page becomes the pointer leaf, and an existing stub path stays"
else
  bad "install: the old copy survived, or the existing glossary was overwritten"
  cat "$tmp/out"
fi

# --- a manifest the script cannot read stops it ----------------------------

printf 'bogus some/file.md\n' >>"$tmp/src/scripts/manifest"
"$vendor" --source "$tmp/src" --target "$tmp/repo" check >/dev/null 2>&1
if [ $? = 2 ]; then
  ok "manifest: an unknown class is a usage error"
else
  bad "manifest: an unknown class did not stop the script"
fi

if [ "$fail" = 0 ]; then
  echo "tests: every expectation held"
else
  echo "tests: failures above"
fi
exit "$fail"
