#!/usr/bin/env bash
# Run a prompt file through Codex CLI non-interactively, with automatic approvals.
#
# Usage: ./run-prompt-codex.sh [-m MODEL] [-e EFFORT] [-s NAME] PROMPT_FILE
#   -m MODEL   Model name (default: Codex's own default, its latest model)
#   -e EFFORT  Reasoning effort: low, medium, high, or xhigh (default: medium)
#   -s NAME    Save the session under NAME (default: ephemeral, nothing saved).
#              Resume later with `codex resume NAME`.
#   -h         Show this help
#
# Examples:
#   ./run-prompt-codex.sh prompts/pre-open-analysis.md
#   ./run-prompt-codex.sh -s 2026-11-18-after-close prompts/after-close-analysis.md
#   ./run-prompt-codex.sh -e high prompts/after-close-analysis.md
#   ./run-prompt-codex.sh -m gpt-5.5 prompts/review.md

set -euo pipefail

usage() {
  sed -n '2,15s/^# \{0,1\}//p' "$0"
}

model=""
effort="medium"
session_name=""

while getopts ":m:e:s:h" opt; do
  case "$opt" in
    m) model="$OPTARG" ;;
    e) effort="$OPTARG" ;;
    s) session_name="$OPTARG" ;;
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

# Sessions are not saved unless -s NAME is given.
if [[ -z "$session_name" ]]; then
  args+=(--ephemeral)
  # "-" tells codex exec to read the prompt from stdin.
  exec codex "${args[@]}" - < "$prompt_file"
fi

# `codex exec` has no flag to name a session, so run it, read the session id
# from the header it prints on stderr, then register NAME in Codex's session
# index (append-only; the latest entry for an id wins) so `codex resume NAME` works.
err_file="$(mktemp)"
trap 'rm -f "$err_file"' EXIT

status=0
codex "${args[@]}" - < "$prompt_file" 2> >(tee "$err_file" >&2) || status=$?
wait  # let the stderr tee finish flushing

session_id="$(sed -n 's/^session id: //p' "$err_file" | head -n 1)"
index_file="${CODEX_HOME:-$HOME/.codex}/session_index.jsonl"

if [[ -z "$session_id" ]]; then
  echo "Warning: could not determine session id; session was not named '$session_name'." >&2
else
  name_json="$(printf '%s' "$session_name" | sed 's/\\/\\\\/g; s/"/\\"/g')"
  printf '{"id":"%s","thread_name":"%s","updated_at":"%s"}\n' \
    "$session_id" "$name_json" "$(date -u +%Y-%m-%dT%H:%M:%S.%NZ)" >> "$index_file"
  echo "Saved session $session_id as '$session_name' (resume: codex resume \"$session_name\")" >&2
fi

exit "$status"
