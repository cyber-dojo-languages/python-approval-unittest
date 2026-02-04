#!/usr/bin/env bash
set -Eeu

readonly REGEX="image_name\": \"(.*)\""
readonly JSON=`cat docker/image_name.json`
[[ ${JSON} =~ ${REGEX} ]]
readonly IMAGE_NAME="${BASH_REMATCH[1]}"

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
readonly APPROVALTESTS_EXPECTED="approvaltests-16.3.0"
readonly PLUGINS=$(docker run --rm -i ${IMAGE_NAME} sh -c 'pytest --version --version' | grep 'approvaltests')

APPROVALTESTS_REGEX=" approvaltests-[0-9\.]*"
[[ ${PLUGINS} =~ ${APPROVALTESTS_REGEX} ]]
readonly APPROVALTESTS_ACTUAL="${BASH_REMATCH[*]}"

if echo "${APPROVALTESTS_ACTUAL}" | grep -q "${APPROVALTESTS_EXPECTED}"; then
  echo "VERSION CONFIRMED as ${APPROVALTESTS_EXPECTED}"
else
  echo "VERSION EXPECTED: ${APPROVALTESTS_EXPECTED}"
  echo "VERSION   ACTUAL: ${APPROVALTESTS_ACTUAL}"
  exit 42
fi
