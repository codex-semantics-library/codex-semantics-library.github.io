---
layout: default
title: Modular analysis
parent: Concepts
---

A modular analysis can analyze *parts* of a program, for instance,
analyze a function `f` without having access to the code of the
functions that call `f` or are called by `f`.

The opposite of a modular analysis is a [whole-program
analysis](/docs/concepts/whole_program_analysis.html), which requires the
analyzer to have access to the code of the entire program.

Codex allows performing both modular and whole-program analyses.
