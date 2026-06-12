---
# All detailed paper info is in _data/publications.yml
layout: paper
parent: Publications
title: "STTT'26"
categories: new publication
date: 2026-02-20
nav_order: 2026-02-20
katex: True
---

## Context

Low-level programs often use null pointers intentionally: for instance, to mark
the end of a linked list, represent an absent value, or encode special cases in
data structures. This is convenient, but it is also one of the most common ways
to introduce memory errors: a program crashes, or becomes exploitable, when a
null pointer is dereferenced.

Static analyzers can prove that these errors do not happen, but they often need
type annotations to do so modularly. For pointer nullness, the useful distinction
is:

- $$\tau?$$ for pointers that may be null,
- $$\tau+$$ for pointers guaranteed to be non-null,
- $$\tau*$$ for pointers whose nullability has not yet been specified.

The problem is that annotating a large C interface by hand is tedious and easy to
get wrong. Worse, changing one annotation can both remove errors and reveal new
ones elsewhere. Marking a field as nullable, for example, makes writing `NULL`
to it legal, but any later read from that field must now consider the null case.
So the set of reported errors is not monotonic in the obvious sense.

## Goal

The goal of the paper is to infer the missing pointer nullability annotations
automatically. Starting from a C or binary program and a Typed C specification
with unspecified pointers, the analysis should replace each $$\tau*$$ by either
$$\tau+$$ or $$\tau?$$ so that the resulting contract is precise enough to prove
the absence of null-pointer dereferences.

The desired result is the smallest such contract: keep as many pointers non-null
as possible, and introduce nullable annotations only when the program actually
needs them.

## Main idea

The key observation is to treat annotations as an abstract domain. A whole
specification becomes a point in a lattice: at the bottom, every unknown pointer
is assumed non-null; moving upward relaxes individual annotations from $$+$$ to
$$?$$.

The inference then runs a least fixpoint computation:

1. Start with all unspecified pointers set to non-null.
2. Run the type checker.
3. When the type checker finds that a null value is sent to a location currently
   typed as non-null, relax the corresponding annotation to nullable.
4. Repeat until no such type errors remain.

This sounds simple, but the paper explains why the algorithm should focus on
type-checking errors rather than null dereference errors. A dereference failure
may be far away from the annotation that caused it, and identifying the right
contract to weaken can require a trace analysis. By contrast, a type-checking
error caused by sending `0` to a non-null type points directly to the type whose
domain is too small.

Paradoxically, the inference can prove absence of null-pointer dereferences by
temporarily ignoring dereference errors during the search, and using only the
contract violations that say "this value does not fit this type".

## Formal result

The paper formalizes this idea on a small strongly typed imperative language.
The language has two important operations:

- `rcv tau`, where the program receives an unknown value satisfying type
  $$\tau$$,
- `send tau`, where the program must prove that a value satisfies type $$\tau$$.

Function calls, function returns, memory reads, and memory writes can all be
viewed through this receive/send interface. The specification determines the
domain of each type, and larger annotations allow more values.

The main theoretical results are:

- If a precise type checker exists and there is some annotation that makes the
  program type-check without errors, then the fixpoint computation finds one.
- The annotation found is minimal in the annotation lattice: it introduces only
  the nullable qualifiers needed to fix the relevant contract violations.
- If the type checker is sound but imprecise, the inference remains sound, but
  may infer more nullable annotations than necessary because false alarms must
  be treated conservatively.

This separates the generic inference method from the particular nullness
analysis. In principle, the same construction can infer other type refinements,
as long as annotations form a finite lattice whose order is compatible with the
interpretation of types.

## Application in Codex

The method is implemented in [Codex](/), using its abstract-interpretation-based
type checker for the Typed C dependent type system. Typed C already supports
rich specifications for C and binary programs, including dependent types and
memory invariants; this work adds an inference loop for pointer nullability
annotations.

In the C setting:

- passing an argument to a function is a `send` to the function parameter type,
- receiving a return value is a `rcv` from the return type,
- writing through memory is a `send` to the target memory type,
- reading from memory is a `rcv` from the stored type,
- dereferencing a pointer includes an assertion that the pointer is not null.

The implementation of the fixpoint loop itself is small, around 200 lines of
OCaml. Most of the engineering effort is in making the type checker report useful
explanations: when an abstract value does not fit a type, the inference must know
which annotation should be relaxed. This is especially important for structured
C values, such as records with many fields or values involving dependent types.

## Evaluation

The implementation is evaluated on C benchmarks already analyzed by Codex,
including OS code or kernel fragments, data-structure-heavy examples, and Olden
benchmarks. The experiment compares three specifications:

- `lower`: all inferred pointer annotations are set to non-null,
- `advised`: annotations written manually after code inspection,
- `infer`: annotations produced by the new inference algorithm.

On the reported benchmarks, the inferred specifications produce the same number
of alarms as the manually advised specifications, except for one case where the
inferred specification removes more false alarms. No true errors are reported
with the inferred specifications. The inferred annotations are also at least as
precise as the manual ones: they use the same number, or fewer, nullable
annotations.

The main practical limitation appears on incomplete library code. If no caller
ever passes `NULL` to a function, the least fixpoint may infer that the function
does not accept null, even if a library designer would prefer the more general
contract. This is not a bug in the algorithm; it follows from asking for the
smallest contract justified by the analyzed code.

## Going further

- Read the [**paper**](/assets/publications/pdfs/2026-sttt-null-pointer-inference.pdf).
- Published in the [International Journal on Software Tools for Technology Transfer](https://doi.org/10.1007/s10009-026-00846-0).
- The method builds on the TypedC type system used by Codex for semantic
  type-checking of C and binary programs.
