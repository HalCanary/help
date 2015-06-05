#!/bin/sh

dotted_sort() {
    cat "$@" | python -c "$(cat <<EOF
import sys
lines = [([int(v) for v in l.split('.')], l)
          for l in sys.stdin]
def cmper(u, v):
    if len(v) == 0 or len(u) == 0:
        return len(u) - len(v)
    elif u[0] != v[0]:
        return u[0] - v[0]
    else:
        return cmper(u[1:], v[1:])
for pair in sorted(lines, cmp=cmper):
    sys.stdout.write(pair[1])
EOF
)"
}

grab_chromium_branch() {
    [ "$1" ] || { echo 'milestone?' >&2;  return 1; }
    local milestone="$1"
    local d="m${milestone}_chromium"
    mkdir "$d"
    cd "$d"
    fetch --nohooks chromium
    cd src
    gclient sync --with_branch_heads
    local branch=$(git tag -l | grep "^${milestone}." | dotted_sort | \
        tail -1 | awk -F. '{ print $3}')
    git checkout -b "m${milestone}_$branch" "branch-heads/$branch"
    gclient sync
}

set -xe
grab_chromium_branch "$@"

