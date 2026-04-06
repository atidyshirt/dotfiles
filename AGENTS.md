# Agent instructions

You are a **coding agent** (for example Cursor) working in this repository.
Follow these instructions when you edit files, answer questions, or propose
changes—unless the user overrides you in a message.

## Before you change Nix or layout

Read **[docs/structure.md](docs/structure.md)** first. It is the source of
truth for flake targets, how `machines/` and `users/jordanp/` relate, and how
Home Manager modules connect. Keep your edits consistent with that document.

## How this file works with Cursor rules

**This file** applies across the whole repo. It does **not** filter by file
type.

When you need **file-type–specific** guidance, check
[`.cursor/rules/*.mdc`](.cursor/rules/)—those rules use `globs` (for example
`**/*.nix`) so they attach when the user is working with matching files. Example:
[`.cursor/rules/nix.mdc`](.cursor/rules/nix.mdc) for Nix.

If you add new scoped rules, use the same `*.mdc` + frontmatter pattern. Reserve
`alwaysApply: true` for rare, global rules.

## When you edit Markdown

Follow the
[Google Markdown style guide](https://google.github.io/styleguide/docguide/style.html),
especially
[Minimum viable documentation](https://google.github.io/styleguide/docguide/style.html#minimum-viable-documentation):
ship small, accurate docs; delete stale content instead of letting it rot.

**Conventions:** one H1 per file, ATX headings, roughly 80-column wrapped prose
(except links, tables, headings, fenced blocks), fenced code blocks with a
language, meaningful link text, and a **See also** section when it helps.

**Structure:** Prefer **one topic per file** under `docs/`. Start from
[`docs/index.md`](docs/index.md) as the hub. When you add a topic, create a new
file and link it from the index or a sibling page—do not pile unrelated
sections into one long file.

## When you edit Nix

Follow **[docs/structure.md](docs/structure.md)** and the scoped rule
[`.cursor/rules/nix.mdc`](.cursor/rules/nix.mdc). In short: keep machine wiring in
`machines/*`, follow `users/jordanp/modules/` (`default.nix`, `darwin.nix`,
`linux.nix`, `topic/default.nix`), split modules for readability, and keep
`flake.nix` thin.

## Quick links

*   [`docs/structure.md`](docs/structure.md) — flake targets, paths, diagram.
*   [Google Markdown style guide](https://google.github.io/styleguide/docguide/style.html)
