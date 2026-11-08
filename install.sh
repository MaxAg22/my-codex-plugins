#!/usr/bin/env bash

set -eu

REPO_URL="https://github.com/MaxAg22/my-codex-plugins.git"
PROJECT_ROOT="$PWD"
TEMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

if ! git clone --depth 1 --quiet "$REPO_URL" "$TEMP_DIR/repo"; then
  echo "Error: could not download my-codex-plugins." >&2
  exit 1
fi

SOURCE_SKILLS="$TEMP_DIR/repo/skills"
SOURCE_AGENTS="$TEMP_DIR/repo/agents"
TARGET_SKILLS="$PROJECT_ROOT/.agents/skills"
TARGET_AGENTS="$PROJECT_ROOT/.codex/agents"

for skill in "$SOURCE_SKILLS"/*; do
  if [ ! -e "$skill" ]; then
    continue
  fi

  name="${skill##*/}"
  if [ -e "$TARGET_SKILLS/$name" ]; then
    echo "Error: skill '$name' already exists in .agents/skills/. Nothing was installed." >&2
    exit 1
  fi
done

for agent in "$SOURCE_AGENTS"/*; do
  if [ ! -e "$agent" ]; then
    continue
  fi

  name="${agent##*/}"
  if [ -e "$TARGET_AGENTS/$name" ]; then
    echo "Error: agent '$name' already exists in .codex/agents/. Nothing was installed." >&2
    exit 1
  fi
done

if ! mkdir -p "$TARGET_SKILLS" "$TARGET_AGENTS"; then
  echo "Error: could not create the Codex skill and agent folders." >&2
  exit 1
fi

if ! cp -R "$SOURCE_SKILLS"/. "$TARGET_SKILLS"/; then
  echo "Error: could not copy the skills." >&2
  exit 1
fi

if ! cp -R "$SOURCE_AGENTS"/. "$TARGET_AGENTS"/; then
  echo "Error: could not copy the agents." >&2
  exit 1
fi

echo "Installed skills in .agents/skills/ and agents in .codex/agents/."
