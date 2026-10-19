# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A directory of standalone U.S. market-analysis notes, not an application. There is no build system, source code, or test suite. `AGENTS.md` holds the full repository guidelines; the essentials are below.

## Layout and naming

- One report per session, at the repo root: `YYYY-MM-DD-market-watch.md` (date = session date).
- One report file accumulates the whole trading day. Existing notes start with a pre-open section (snapshot, drivers, calendar, earnings, trading framework, bottom line), and later in the day get appended sections such as "Midday update" or "After-close analysis", which grade the market against the morning framework. When updating a day, append to that day's file rather than creating a new one.
- `logs/` is git-ignored (MCP server logs). Don't commit it.
- Supporting images or datasets, if ever needed, go under `assets/YYYY-MM-DD/` and are linked with relative paths.

## Style rules

- One H1 title, then descriptive H2/H3 headings. Short paragraphs, bullets for actionable points, tables for comparable market data.
- Use Eastern Time (`ET`) for session events, spell out ambiguous dates, and label estimates ("about", "approximately").
- Link factual claims to reputable public sources with inline Markdown links.
- Distinguish pre-market figures from post-release or intraday updates, and say when data may be stale.
- Keep the closing `## Disclaimer` (informational, not personalized investment advice).

## Checks before committing

- `git diff --check` for whitespace problems; `git diff --word-diff` to review prose edits.
- `npx markdownlint-cli2 "*.md"` for style checks, if Node.js is available.
- Verify dates, release times, quoted levels, and that source URLs resolve.

## Commits

Concise, imperative summaries, one report or coherent correction per commit (e.g. `add October 16 market watch`).
