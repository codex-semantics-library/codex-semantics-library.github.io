---
# All detailed paper info is in _data/publication.yml
layout: paper
parent: Publications
title: "OOPSLA'24"
categories: new publication
date: 2024-08-28
nav_order: 2024-08-28
---

## Context

When you program in C, it is easy to make programming mistakes that
directly compromise spatial memory safety, such as null pointer
dereferences, type confusion, or buffer overflows. These direct memory
corruption errors are a subclass of undefined behaviors in C, i.e.,
programming mistakes that you should not make, such as division by
zero, signed integer overflow, or breaking the C strict aliasing
rules. The compiler assumes that you do not make these mistakes, which
are not checked, meaning that if you do make them, your program
may crash, corrupt memory, or exhibit other unpredictable
behaviors. Moreover, these mistakes can be exploited by an attacker to
take control of the execution of the processus running your program,
and this represents both the most common and the most severe kind of
security vulnerabilities.


Thus, it is important to ensure that your program is free from
these undefined behaviors. Providing tools that do this in a
practical way is one of the main purposes behind the development of
[Codex](https://codex.top), a sound static analyzer based on abstract
interpretation. The paper focuses on particular method that can
ensure spatial memory safety of C or binary programs almost
automatically, requiring only a small amount of type annotations.


## Example


TODO


## Key contributions and take-away

One of the main challenges when analyzing C programs is the
representation of the memory. The paper proposes a **type system**,
inspired by that of C, as the basis for this abstraction. While
initial versions of this type system have been proposed in
[VMCAI'22](/papers/2022-vcmai-lightweight-shape-analysis.html) and
used in [RTAS'21](/papers/2021-rtas-no-crash-no-exploit.html), this
paper extends it significatively with new features like support for
union, parameterized, and existential types. The paper shows how to
combine all these features to encode many complex low-level idioms,
such as flexible array members or discriminated unions using a memory
tag or bit-stealing. This makes it possible to apply Codex to
challenging case studies, such as the unmodified Olden benchmark, or
parts of OS kernels or the Emacs Lisp runtime.

The reasons why a C or machine code program is memory-safe generally
depend on invariants on the values, such as "this pointer points to a
memory area whose length corresponds to the contents of this
integer". Thus, a type system that can be used to guarantee memory
safety must use dependent types. This makes type checking particularly
complex, which is why we use abstract interpretation to type-check the
program. Abstract interpretation also allows automatical infererence
of other kinds of program invariants (beyond those expressed by the
type system), that helps the overall analysis to type-check the
program and verify its spatial memory safety.

Often, static analyzers are
[whole-program](/docs/concepts/whole_program_analysis.html), meaning
that they need to know the entire program to perform the
analysis. This is useful when using the analyzer for validation, but
prevents the use of the analyzer while developing. One of the nice
benefits of the type system is that it allows [modular
analysis](/docs/concepts/modular_analysis.html), using the types of
the function prototype rather than using the code in the function
definition.

Finally, we investigate properties of our type system. Contrary to
type systems like Rust's, our type system is structural: we don't
track all the references to an object, which eases analysis
automation. Such a type system is particularly convenient when there
are complicated sharing patterns and no issues of temporal memory
safety, as found in statically-allocated OS kernels or
garbage-collected programs. We investigate the properties of our type
system and have discovered interesting features like the *mild
update*, allowing switching between the cases in a union provided
that some monotonicity conditions are met.

## Further information

- Interested in using it? Be an early adopter, check the
[**tutorial**](/docs/tutorial_oopsla2024.pdf) and try proving that your
code is (spatially) memory-safe now!

- Interested in the theory? Read the
[**paper**](/assets/publications/pdfs/2024-oopsla-full-with-appendices.pdf).

- You can check the [artifact](https://zenodo.org/records/13383433),
which contains the version of Codex used by the artifact reviewers, as
well as the benchmarks used.

- To appear at
  [OOPSLA'2024](https://2024.splashcon.org/track/splash-2024-oopsla).
