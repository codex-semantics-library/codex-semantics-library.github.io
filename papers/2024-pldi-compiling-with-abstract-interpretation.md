---
# All detailed paper info is in _data/publication.yml
layout: paper
parent: Publications
title: "PLDI'24 Research Paper"
categories: new publication
date: 2024-04-22
nav_order: 2024-04-22
---

## Context

Software analyzers and compilers have a lot in common: they both have to read and
understand source code in order to **prove facts about it** and **transform it** into
an equivalent code. While the goal of an analyzer is to prove facts (correctness, safety...)
about the source, it often transforms the code through rewrites to make the analysis easier.
As an example, rewriting `e + e` into `2*e` makes it obvious that the value is even.
Symmetrically, the goal of a compiler is code transformation, but compilers often
run analyses on the code to perform optimizations. For instance, many compilers
remove variables which are never read by the program: this is possible thanks to
a liveness analysis.

With this in mind, it seems compilers and analyzers could be written using the same
core library of analysis and program transformations.
A problem that creeps up in both case is known as the **phase-ordering problem**:
in what order should we run transformations and analyses? Should we start by analyzing
the code, and use that information to transform it? Or rather should first transform the
code and then run the analysis on the simplified version? Should we alternate between
transformation and analysis passes?

In practice, the best precision is obtained by running transformations and analyses
simultaneously. Fortunately, **abstract interpretation** is well-suited to fuse different analyses together. In abstract interpretation, each analysis is viewed as a domain,
and all domains have a common signature/interface. This allows running multiple analyses
in parallel (using a product of the relevant domain), and have them collaborate
(domains can query other domain to see if they can prove a property).

## Contributions

Our paper shows the following novel results:
- A standard abstract interpretation framework can be turned into a
  compiler: create a domain that is a **free-algebra** of the domain signature (i.e.
  implement each domain operation with a separate constructor), then the analysis
  result can be used to reconstruct the program graph.
- Functors (functions that build a new abstract domain from abstract domains received as
  arguments) can mimic compiler passes, with, functor soundness and completness
  implying forward and backward simulation between source and compiled program respectively.
- We extend these transformations to compilation from a small imperative language
  to an SSA form
- We show that transforming to SSA and running a numerical analysis on the SSA form
  simultaneously is more precise than classical numerical analysis. Furthermore,
  this domain doesn't suffer from precision loss when analyzing compiled code.

## Further information

- Read the **paper**: either [published version](/assets/publications/pdfs/2024-pldi-compiling-with-abstract-interpretation.pdf) or the [version with appendices](/assets/publications/2024-pldi-compiling-with-abstract-interpretation-with-appendix.pdf)
- Download the [software artifact](https://doi.org/10.5281/zenodo.10895582) from
  Zenodo to try out our example analyzer and explore the code.
- To appear at the [Programming Language Design and Implementation (PLDI) 2024 conference](https://pldi24.sigplan.org/)
