#!/usr/bin/env bash
# Run a prompt file through Claude Code non-interactively, in auto mode.
#
# Usage: ./run-prompt-claude.sh [-m MODEL] [-e EFFORT] PROMPT_FILE
#   -m MODEL   Model alias or full name (default: opus, the latest Opus model)
#   -e EFFORT  Reasoning effort: low, medium, high, xhigh, or max (default: medium)
#   -h         Show this help
#
# Examples:
#   ./run-prompt-claude.sh prompts/pre-open-analysis.md
#   ./run-prompt-claude.sh -e high prompts/after-close-analysis.md
#   ./run-prompt-claude.sh -m sonnet prompts/review.md
#   ./run-prompt-claude.sh -m claude-opus-5-5 prompts/after-close-analysis.md

set -euo pipefail

usage() {
  sed -n '2,13s/^# \{0,1\}//p' "$0"
}

model="opus"
effort="medium"

while getopts ":m:e:h" opt; do
  case "$opt" in
    m) model="$OPTARG" ;;
    e) effort="$OPTARG" ;;
    h) usage; exit 0 ;;
    :) echo "Error: -$OPTARG requires a value." >&2; usage >&2; exit 2 ;;
    \?) echo "Error: unknown option -$OPTARG." >&2; usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

case "$effort" in
  low|medium|high|xhigh|max) ;;
  *) echo "Error: invalid effort '$effort' (use low, medium, high, xhigh, or max)." >&2; exit 2 ;;
esac

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 2
fi

prompt_file="$1"

if [[ ! -f "$prompt_file" || ! -r "$prompt_file" ]]; then
  echo "Error: prompt file not found or unreadable: $prompt_file" >&2
  exit 1
fi

if [[ ! -s "$prompt_file" ]]; then
  echo "Error: prompt file is empty: $prompt_file" >&2
  exit 1
fi

if ! command -v claude >/dev/null 2>&1; then
  echo "Error: 'claude' CLI not found on PATH." >&2
  exit 127
fi

# Feed the prompt on stdin so long or multi-line files are passed intact.
exec claude -p \
  --permission-mode auto \
  --model "$model" \
  --effort "$effort" \
  < "$prompt_file"
