#!/bin/sh
# vendor: carry the pointer leaves and the tooling files into a repository,
# stamp when its handbook was last checked against the source, or check that
# the carried files still match.
#
# Handbook: /handbook/adoption/README.md owns the three classes of file, the
# marker, and the four verbs this script runs; scripts/manifest is the list.
#
# Exit status: 0 clean or done, 1 on drift or a missing file, 2 on a usage
# error or a manifest the script cannot read.

set -u

usage() {
  cat <<'USAGE'
Usage: vendor.sh [--source DIR] [--target DIR] install|update|check|diff

  install  carry every class into a repository that has none of it, and
           write the marker
  update   refresh the pointer leaves and the tooling files, name any stub
           still absent, and stamp the marker with the source's state
  check    report every carried file that differs from the source at the
           commit the marker names (DRIFT) and every one the source has
           changed since (UPDATE); exit 1 on DRIFT or on a MISSING file
  diff     print the drift as a patch that applies in a source checkout

Options:
  --source DIR   the handbook-tools checkout (default: the one this script
                 lives in)
  --target DIR   the repository to act on (default: the git root of the
                 current directory)
  -h, --help     this text

Neither install nor update commits: the target's diff is what a reviewer
reads. Run against the source itself, check only confirms that the manifest
names files that exist.
USAGE
}

SOURCE_SLUG=${HANDBOOK_SOURCE_SLUG:-cynkra/handbook-tools}
SOURCE_URL=${HANDBOOK_SOURCE_URL:-https://github.com/cynkra/handbook-tools}

source=
target=
verb=
while [ $# -gt 0 ]; do
  case "$1" in
    --source) [ $# -ge 2 ] || { echo "vendor: --source needs a value" >&2; exit 2; }; source=$2; shift ;;
    --target) [ $# -ge 2 ] || { echo "vendor: --target needs a value" >&2; exit 2; }; target=$2; shift ;;
    -h | --help) usage; exit 0 ;;
    install | update | check | diff) verb=$1 ;;
    *) echo "vendor: unknown argument '$1'" >&2; usage >&2; exit 2 ;;
  esac
  shift
done
[ -n "$verb" ] || { usage >&2; exit 2; }

if [ -z "$source" ]; then
  source=$(cd "$(dirname "$0")/.." && pwd -P)
else
  source=$(cd "$source" && pwd -P) || { echo "vendor: no such source: $source" >&2; exit 2; }
fi
manifest=$source/scripts/manifest
[ -f "$manifest" ] || { echo "vendor: $source carries no scripts/manifest" >&2; exit 2; }

if [ -z "$target" ]; then
  target=$(git rev-parse --show-toplevel 2>/dev/null) ||
    { echo "vendor: not inside a git repository; pass --target" >&2; exit 2; }
fi
target=$(cd "$target" && pwd -P) || { echo "vendor: no such target: $target" >&2; exit 2; }

if [ "$source" = "$target" ] && [ "$verb" != check ]; then
  echo "vendor: $target is the source; nothing to carry into it" >&2
  exit 2
fi

tmp=$(mktemp -d "${TMPDIR:-/tmp}/vendor.XXXXXX") || exit 2
trap 'rm -rf "$tmp"' EXIT INT TERM

# The manifest, read once and validated before anything is touched.
sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$manifest" >"$tmp/manifest"
bad=$(awk '$1 != "pointer" && $1 != "shared" && $1 != "stub" { print $1; exit }' "$tmp/manifest")
[ -z "$bad" ] || { echo "vendor: unknown class '$bad' in $manifest" >&2; exit 2; }

today=$(date +%Y-%m-%d)
commit=$(git -C "$source" rev-parse HEAD 2>/dev/null || echo unknown)
source_date=$(git -C "$source" log -1 --format=%cs HEAD 2>/dev/null || echo unknown)
marker=$target/.handbook-source

# Where a class's file lives in the source, relative to the source root.
origin() { # class path
  case "$1" in
    pointer) echo "pointers/$2" ;;
    shared) echo "$2" ;;
    stub) echo "stubs/$2" ;;
  esac
}

# The baseline a check compares against: the source at the commit the
# marker names, so that DRIFT means "edited here" and a change in the source
# since then is UPDATE. A squash merge in the source retires that commit, and
# then the source's head is the baseline and the two cannot be told apart.
base=HEAD
base_note=
if [ -f "$marker" ]; then
  checked=$(sed -n 's/^commit: //p' "$marker")
  if [ -n "$checked" ] && git -C "$source" cat-file -e "$checked^{commit}" 2>/dev/null; then
    base=$checked
  else
    base_note="the marker's commit is not in the source, so its head is the baseline and a DRIFT may be an update instead"
  fi
fi
base_date=$(git -C "$source" log -1 --format=%cs "$base" 2>/dev/null || echo unknown)

say() { printf '%-10s %s\n' "$1" "$2"; }
count() { echo "$1" >>"$tmp/$2"; }

# The three views of one carried file, written to tmp for comparison: what
# the target has, what the source had at the baseline, what it has now.
views() { # class path -> sets have_base
  from=$(origin "$1" "$2")
  cat "$target/$2" >"$tmp/target" 2>/dev/null || : >"$tmp/target"
  cat "$source/$from" >"$tmp/head"
  if git -C "$source" cat-file -e "$base:$from" 2>/dev/null; then
    git -C "$source" show "$base:$from" >"$tmp/base"
    have_base=1
  else
    have_base=0
  fi
}

check_one() { # class path
  from=$(origin "$1" "$2")
  [ -f "$source/$from" ] || { say MISSING "$from (absent from the source)"; count "$2" findings; return; }
  if [ "$source" = "$target" ] || [ "$1" = stub ]; then return; fi
  [ -f "$target/$2" ] || { say MISSING "$2"; count "$2" findings; return; }
  views "$1" "$2"
  if [ "$have_base" = 1 ]; then
    if ! cmp -s "$tmp/base" "$tmp/target"; then
      say DRIFT "$2 (differs from the source at the marker's commit)"
      count "$2" findings
    elif ! cmp -s "$tmp/base" "$tmp/head"; then
      say UPDATE "$2 (the source changed it since the marker's commit)"
      count "$2" updates
    fi
  elif ! cmp -s "$tmp/head" "$tmp/target"; then
    say DRIFT "$2 (differs from the source's head, which is the baseline here)"
    count "$2" findings
  fi
}

diff_one() { # class path
  [ "$1" = stub ] && return
  [ -f "$target/$2" ] || return
  [ -f "$source/$(origin "$1" "$2")" ] || return
  views "$1" "$2"
  from=$tmp/head
  [ "$have_base" = 1 ] && from=$tmp/base
  cmp -s "$from" "$tmp/target" && return
  diff -u --label "a/$2" --label "b/$2" "$from" "$tmp/target"
}

carry() { # class path
  from=$(origin "$1" "$2")
  src=$source/$from
  dst=$target/$2
  [ -f "$src" ] || { say MISSING "$from (absent from the source)"; count "$2" findings; return; }
  case "$1" in
    pointer | shared)
      mkdir -p "$(dirname "$dst")"
      cp "$src" "$dst"
      [ -x "$src" ] && chmod +x "$dst"
      count "$2" carried ;;
    stub)
      [ -f "$dst" ] && return
      # A stub declined is the repository's decision: update names it and
      # neither verb fails on it.
      case "$verb" in
        update) say ABSENT "$2 (a stub; install carries it, and leaving it out is the repository's choice)" ;;
        install)
          mkdir -p "$(dirname "$dst")"
          cp "$src" "$dst"
          count "$2" installed ;;
      esac ;;
  esac
}

case "$verb" in
  check) while read -r class path; do check_one "$class" "$path"; done <"$tmp/manifest" ;;
  diff)
    while read -r class path; do diff_one "$class" "$path"; done <"$tmp/manifest"
    exit 0 ;;
  install | update) while read -r class path; do carry "$class" "$path"; done <"$tmp/manifest" ;;
esac

n() { [ -f "$tmp/$1" ] && wc -l <"$tmp/$1" | tr -d ' ' || echo 0; }
findings=$(n findings)

if [ "$verb" = check ]; then
  if [ "$source" = "$target" ]; then
    if [ "$findings" = 0 ]; then
      echo "vendor: the manifest names $(wc -l <"$tmp/manifest" | tr -d ' ') files, all present"
      exit 0
    fi
    echo "vendor: $findings files the manifest names are absent"
    exit 1
  fi
  if [ ! -f "$marker" ]; then
    say MISSING ".handbook-source (install writes it)"
    findings=$((findings + 1))
  else
    [ -z "$base_note" ] || say NOTE "$base_note"
    marker_date=$(sed -n 's/^source-date: //p' "$marker")
    [ -n "$marker_date" ] && [ "$marker_date" != "$source_date" ] &&
      say BEHIND "this handbook was last checked against the source of $marker_date; the source is at $source_date (${commit%${commit#???????}})"
  fi
  updates=$(n updates)
  if [ "$findings" = 0 ]; then
    extra=
    [ "$updates" = 0 ] || extra="; $updates files have an update available"
    echo "vendor: clean (every carried file matches $SOURCE_SLUG at ${base%${base#???????}} of $base_date$extra)"
    exit 0
  fi
  echo "vendor: $findings findings"
  exit 1
fi

if [ "$findings" != 0 ]; then
  echo "vendor: $verb stopped with $findings problems above; the marker was not written"
  exit 1
fi

{
  cat <<MARKER
# The source of the shared documentation system, the state of it this
# handbook was last checked against (its commit, that commit's date, and the
# day of the check), and the files carried from it unchanged. The vendoring
# script reads this, and handbook/meta/local/README.md says what stays local.
source: $SOURCE_SLUG
url: $SOURCE_URL
commit: $commit
source-date: $source_date
checked: $today
carried:
MARKER
  awk '$1 != "stub" { print "  - " $2 }' "$tmp/manifest"
} >"$marker"

echo "vendor: $verb done ($(n carried) files carried, $(n installed) stubs installed; checked against ${commit%${commit#???????}} of $source_date)"
exit 0
