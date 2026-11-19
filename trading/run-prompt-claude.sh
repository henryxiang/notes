#!/usr/bin/env bash
# Run a prompt file through Claude Code non-interactively, in auto mode.
#
# Usage: ./run-prompt-claude.sh [-m MODEL] [-e EFFORT] [-s NAME] PROMPT_FILE
#   -m MODEL   Model alias or full name (default: opus, the latest Opus model)
#   -e EFFORT  Reasoning effort: low, medium, high, xhigh, or max (default: medium)
#   -s NAME    Save the session under NAME (default: session is not saved)
#   -h         Show this help
#
# Examples:
#   ./run-prompt-claude.sh prompts/pre-open-analysis.md
#   ./run-prompt-claude.sh -s 2026-11-18-after-close prompts/after-close-analysis.md
#   ./run-prompt-claude.sh -e high prompts/after-close-analysis.md
#   ./run-prompt-claude.sh -m sonnet prompts/review.md
#   ./run-prompt-claude.sh -m claude-opus-5-5 prompts/after-close-analysis.md

set -euo pipefail

usage() {
  sed -n '2,15s/^# \{0,1\}//p' "$0"
}

model="opus"
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

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: 'jq' not found on PATH (needed to render progress)." >&2
  exit 127
fi

# Colors only when writing to a terminal (respects NO_COLOR).
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  c_dim=$'\033[2m'; c_bold=$'\033[1m'; c_cyan=$'\033[36m'
  c_green=$'\033[32m'; c_red=$'\033[31m'; c_rst=$'\033[0m'
else
  c_dim=""; c_bold=""; c_cyan=""; c_green=""; c_red=""; c_rst=""
fi

# Render stream-json events as a readable progress log.
render='
  def clip($n): gsub("\r"; "") | if length > $n then .[0:$n] + "…" else . end;
  def oneline: gsub("\n"; " ↵ ");
  def ts: now | localtime | strftime("%H:%M:%S");
  def target: (.command // .file_path // .path // .pattern // .url // .query // .description // tostring) | tostring | oneline | clip(140);
  def duration($ms): ($ms / 1000 | floor) as $s | if $s >= 60 then "\($s / 60 | floor)m \($s % 60)s" else "\($s)s" end;
  def summary:
    (if (.content | type) == "array" then (.content | map(.text? // "") | join("\n")) else (.content // "" | tostring) end)
    | split("\n") | map(select(test("\\S"))) as $l
    | if ($l | length) == 0 then "(no output)"
      else ($l[0] | clip(120)) + (if ($l | length) > 1 then "  (+\($l | length - 1) more lines)" else "" end) end;

  if .type == "system" and .subtype == "init" then
    "\($bold)━━ Claude run ━━\($rst)  \($dim)model: \(.model // "?")  ·  \(ts)\($rst)\n"
  elif .type == "assistant" then
    (.message.content[]? |
      if .type == "text" then "\n\($bold)●\($rst) \(.text)\n"
      elif .type == "tool_use" then "\($dim)\(ts)\($rst)  \($cyan)⏺ \(.name)\($rst)  \(.input | target)"
      elif .type == "thinking" then "\($dim)\(ts)  … thinking\($rst)"
      else empty end)
  elif .type == "user" then
    (.message.content[]? | select(type == "object" and .type == "tool_result") |
      if .is_error == true then "           \($red)⎿ ✗ \(summary)\($rst)"
      else "           \($dim)⎿ \(summary)\($rst)" end)
  elif .type == "result" then
    "\n\($dim)────────────────────────────────────────\($rst)\n" +
    (if .is_error == true or .subtype != "success"
     then "\($red)✗ Finished with error (\(.subtype))\($rst)"
     else "\($green)✔ Completed\($rst)" end) +
    "  \($dim)\(duration(.duration_ms // 0))  ·  \(.num_turns // "?") turns  ·  $\(.total_cost_usd // 0 | . * 100 | round / 100)\($rst)"
  else empty end
'

# Sessions are not saved unless -s NAME is given.
if [[ -n "$session_name" ]]; then
  session_args=(--name "$session_name")
else
  session_args=(--no-session-persistence)
fi

# Feed the prompt on stdin so long or multi-line files are passed intact.
# --verbose + stream-json emits every step as it happens; jq --unbuffered shows it live.
claude -p \
  --permission-mode auto \
  --model "$model" \
  --effort "$effort" \
  --output-format stream-json \
  --verbose \
  "${session_args[@]}" \
  < "$prompt_file" \
  | jq -r --unbuffered \
      --arg dim "$c_dim" --arg bold "$c_bold" --arg cyan "$c_cyan" \
      --arg green "$c_green" --arg red "$c_red" --arg rst "$c_rst" \
      "$render"
