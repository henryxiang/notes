# Repository Guidelines

## Project Structure & Module Organization

This directory contains standalone market-analysis notes rather than an application. Keep each report at the repository root and name it `YYYY-MM-DD-market-watch.md`, matching the session date. There are currently no source, test, build, or asset directories. If supporting images or datasets become necessary, group them under a clearly named directory such as `assets/YYYY-MM-DD/` and link to them with relative paths.

## Writing and Validation Commands

No build system or automated test suite is configured. Use lightweight checks before submitting changes:

- `rg --files` lists the notes and helps catch misplaced files.
- `git diff --check` detects trailing whitespace and malformed patch spacing.
- `git diff --word-diff` provides a focused review of prose edits.
- `npx markdownlint-cli2 "*.md"` may be used when Node.js is available; it runs Markdown style checks without adding project dependencies.

Preview edited Markdown in a renderer to verify headings, tables, links, and list spacing.

## Markdown Style & Naming Conventions

Start each report with one H1 title, then organize it with descriptive H2 and H3 headings. Use short paragraphs, bullet lists for actionable points, and tables for comparable market data. Preserve two trailing spaces only when an intentional Markdown line break is needed. Use Eastern Time (`ET`) for U.S. session events, spell out ambiguous dates, and label estimates with words such as “about” or “approximately.” Link factual claims to reputable public sources using inline Markdown links.

## Content Verification Guidelines

There are no coverage targets or test fixtures. Instead, verify dates, release times, quoted market levels, and source URLs before committing. Distinguish pre-market figures from post-release or intraday updates, and state when data may be stale. Retain the disclaimer that analysis is informational and not personalized investment advice.

## Commit & Pull Request Guidelines

Recent commits use concise, imperative summaries such as `add .gitignore` and `created health notes`. Follow that style, for example: `add October 16 market watch`. Keep each commit limited to one report or coherent correction.

Pull requests should summarize the note or correction, identify the market session covered, and call out any figures that require special verification. Link related issues when applicable. Screenshots are unnecessary unless demonstrating a table or rendering problem. Before requesting review, inspect the final diff and confirm all external links resolve.
