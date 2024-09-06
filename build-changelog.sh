#!/bin/bash

set -e

# Temporary file for bundling the output before echoing
OUTPUT_FILE="$(mktemp)"

# All the repos of which changes land in the release
REPOS="pspdev pspsdk psptoolchain psptoolchain-allegrex psptoolchain-extra psp-packages psplinkusb psp-pacman ebootsigner"

# Get the timestamp and name of the latest release of pspdev/pspdev
LAST_RELEASE="$(curl -sfL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/pspdev/pspdev/releases/latest)"
LAST_RELEASE_DATE="$(echo ${LAST_RELEASE}|jq -r '.created_at')"
LAST_RELEASE_NAME="$(echo ${LAST_RELEASE}|jq -r '.name')"

echo "## Pull Requests Included" > "${OUTPUT_FILE}"
echo "" >> "${OUTPUT_FILE}"
echo "Below are the pull requests that were merged since the ${LAST_RELEASE_NAME} release." >> "${OUTPUT_FILE}"
echo "" >> "${OUTPUT_FILE}"

for REPO in ${REPOS}; do
  TMP_FILE="$(mktemp)"
  # Collect the relevant data about the PRs for the current repo that were merged after the lastest release
  curl -sfL \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/pspdev/${REPO}/pulls?state=closed | \
    jq "[.[] | select((.merged_at != null) and (.merged_at >= \"${LAST_RELEASE_DATE}\")) | {merged_at, title, user: .user.login, user_url: .user.html_url, pr_url: .html_url}]" \
    >> "${TMP_FILE}"

  # If the received PRs is not an empty list, add it to the final output
  if [[ ! "$(cat ${TMP_FILE})" =~ ^"[]" ]]; then
    echo "" >> "${OUTPUT_FILE}"
    echo "### ${REPO}" >> "${OUTPUT_FILE}"
    echo "" >> "${OUTPUT_FILE}"
    cat "${TMP_FILE}" | jq -r '.[] | "[\(.title)](\(.pr_url)) by [\(.user)](\(.user_url))"' >> "${OUTPUT_FILE}"
  fi
  rm "${TMP_FILE}"
done

cat "${OUTPUT_FILE}"
rm "${OUTPUT_FILE}"
