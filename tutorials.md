---
title: Tutorials
layout: home
nav_order: 1
---


## Tutorial: [Spatial Memory Safety with Dependent Types using Codex](/docs/tutorial_oopsla2024.pdf)

This is the tutorial accompagnying the prototype of our [OOPSLA 2024
research
paper](/papers/2024-oopsla-typedc-dependent-nominal-physical-type-system.html). It
covers all the steps necessary to use our tool to check if a C or
machine code program is exempt of spatial memory safety errors, such
as null pointer dereferences, buffer overflows, or type confusion
errors. It covers in particular:

1. How to run the analysis on a C program, how to configure the C
   analysis, and how to inspect the results.
2. How to run the analysis on a binary executable, how to configure
   the machine code analysis, and how to inspect the results.
3. How to specify the types used in a C programs to refine the results
   of the analysis (which is generally a necessary step to obtain
   memory safety).
