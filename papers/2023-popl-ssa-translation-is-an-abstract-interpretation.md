---
# All detailed paper info is in _data/publication.yml
layout: paper
parent: Publications
title: "POPL'23 Research Paper"
categories: new publication
date: 2023-01-01
nav_order: 2023-01-01
---


## Summary

Conversion to Static Single Assignment (SSA) form is usually viewed as
a syntactic transformation algorithm that gives unique names to
program variables, and reconciles these names using "phi" functions
based on a notion of domination. We instead propose a semantic
approach, where SSA translation is performed using a simple dataflow
analysis. Based on a new technique to use cyclic terms in abstract
domains, we propose a Symbolic Expression abstract domain that
performs a Global Value Numbering analysis, upon which we build our
SSA translation.  This implies a shift in perspective, as global value
numbering becomes a prerequisite of SSA translation, instead of
depending on SSA.

One application to performing SSA Translation by Abstract
Interpretation is that SSA optimisations passes can be implemented as
a combination of abstract domains, allowing to perform several
optimizations simultaneously to solve the usual phase ordering problem
and avoiding tedious maintainance of SSA invariants.

Our main motivation for this research is the design of Codex, an
analyser for machine code which uses SSA as its main intermediate
representation. Machine code is too low-level to allow SSA translation
without a prior semantic analysis, while SSA is an intermediate
representation that makes static analysis easier than direct analysis
of machine code. Viewing SSA translation as a semantic analysis solves
this chicken-and-egg problem, allowing to simultaneously decompile
machine code to SSA and use the SSA representation to perform the
other semantic analyses (value analysis, memory analysis, and
control-flow analysis).  Our [RTAS 2021
paper](/papers/2021-rtas-no-crash-no-exploit.html) illustrate the use
of such an analysis, combined with a novel type system for machine
code where type checking is also done by abstract interpretation, on
an embedded OS kernel where we prove security properties directly from
its executable.

## Further information

- Read the **paper**: either [published version](https://doi.acm.org?doi=3656392) or the [version with appendices](/assets/publications/pdfs/2023-popl-ssa-translation-is-an-abstract-interpretation-with-appendices.pdf)
- Look at the [slides](/assets/publications/slides/2023-popl-ssa-translation-is-an-abstract-interpretation-slides.pdf) or watch the [video of the talk](https://www.youtube.com/watch?v=wkIfcN3Ipd4)
- Download the [software artifact](https://zenodo.org/records/10895582) which can be used as a reference implementation of our technique.

