#!/bin/bash

cd ${0%/*}

assert () {
  if eval "$*"; then
    echo PASS
  else
    echo FAIL: $*
    exit 1
  fi
}

assert [[ -f Podfile ]]
assert "pod --no-integrate --no-repo-update | grep 'executing pre-commit hook'"
