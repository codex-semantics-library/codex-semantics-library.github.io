---
layout: default
title: Whole-program analysis
parent: Concepts
---

A whole-program analysis requires the analyzer to know the entire
program to start. It thus cannot[^1] be applied to parts of a program like
a library or a single function, unlike a [modular
analysis](/concepts/modular_analysis.html).

[^1]: Note that it is often possible to work around the problem by inserting stubs, but these remains work-arounds.
