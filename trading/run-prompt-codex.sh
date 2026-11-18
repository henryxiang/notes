#!/usr/bin/env bash
# Run a prompt file through Codex CLI non-interactively, with automatic approvals.
#
# Usage: ./run-prompt-codex.sh [-m MODEL] [-e EFFORT] PROMPT_FILE
#   -m MODEL   Model name (default: Codex's own default, its latest model)
#   -e EFFORT  Reasoning effort: low, medium, high, or xhigh (default: medium)
#   -h         Show this help
#
# Examples:
#   ./run-prompt-codex.sh prompts/pre-open-analysis.md
#   ./run-prompt-codex.sh -e high prompts/after-close-analysis.md
#   ./run-prompt-codex.sh -m gpt-5.5 prompts/review.md

set -euo pipefail

usage() {
  sed -n '2,12s/^# \{0,1\}//p' "$0"
}

model=""
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
  low|medium|high|xhigh) ;;
  *) echo "Error: invalid effort '$effort' (use low, medium, high, or xhigh)." >&2; exit 2 ;;
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

if ! command -v codex >/dev/null 2>&1; then
  echo "Error: 'codex' CLI not found on PATH." >&2
  exit 127
fi

# --approve-for-me is Codex's counterpart to Claude Code's auto mode: approval
# requests are reviewed automatically inside the workspace-write sandbox.
args=(exec --approve-for-me -c "model_reasoning_effort=\"$effort\"")
if [[ -n "$model" ]]; then
  args+=(--model "$model")
fi

# "-" tells codex exec to read the prompt from stdin.
exec codex "${args[@]}" - < "$prompt_file"
