#!/usr/bin/env bash

set -o errexit
set -o pipefail

source "$HOME/.functions/base"
source "$HOME/.functions/git"

_format () {
  jq -r '.[] | "*** TODO [[" + .html_url + "][" + .repository.full_name + "#" + (.number | tostring) + "-" + .title + "]]",
":PROPERTIES:",
":ID: " + (.id | tostring),
":END:",
.body'
}

echo "** $(/bin/date "+%Y-%m-%d")"
_cached '_github "issues?assignee=$(_github_user)"' | _format | tr -d '\r'
