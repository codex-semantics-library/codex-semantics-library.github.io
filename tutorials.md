---
title: Tutorials
layout: home
nav_order: 1
sidebar: toc
---

# List of tutorials
{:.no_toc}

* List replaced by toc
{:toc}

# Quick start: verifying C code using Frama-C/Codex

1. Download the latest binary release of Frama-C/Codex at https://github.com/codex-semantics-library/codex/releases/
2. Write a small C function in file `test.c`:
```c
int main(int i) { int x = i; if(i > 8) x = 8; return x; }
```
If GCC is not installed, use `test.i` instead of `test.c` (`.i` corresponds to already-preprocessed files).
3. Launch the analysis and obtain a textual report of the analysis:
```sh
./frama_c_codex.exe -codex test.c -codex-exp-dump test.dump && cat test.dump
```
```
test.c:1.26-27: `i' -> [--..--]
test.c:1.32-37: `i > 8' -> {0; 1}
test.c:1.32-33: `i' -> [--..--]
test.c:1.53-54: `x' -> [-0x80000000..8]
Unproved regular alarms:
Unproved additional alarms:
Proved 0/0 regular alarms
Unproved 0 regular alarms and 0 additional alarms.
Solved 0/0 user assertions, proved 0
```
If you are using Emacs' compilation-mode (probably works also in other editors), you can click on each expression, and they will bring you to the location in the file.
4. Obtain an HTML report of the analysis:
   ```sh
   ./frama_c_codex.exe -codex test.c -codex-html-dump test.html
   ```
   <iframe src="{{ '/assets/codexoutputs/quickstart_c.html' | relative_url }}" width="100%" height="400px" frameborder="8" style="border:1px solid #000; border-radius:15px; box-shadow: 0 4px 8px rgba(0,0,0,0.3);"></iframe>
5. That's all to get started! As there are no reported alarms, your code is memory-safe, free from division-by-zero errors, and free from others errors that Codex checks. The most useful options are:
   - `-codex` (launches Codex);
   - `-main` (selects the entry point of the analysis, if not `main`);
   - `-codex-exp-dump out.dump` (produces a textual dump of all expressions);
   - `-codex-html-dump out.html` (produces an HTML equivalent of the dump file);
   - `-codex-type-file a.typ` (uses TypedC specification, useful when
     analyzing functions independently, which is covered by the next
     tutorial)

Happy verification!


# Tutorial: [Spatial Memory Safety using Codex and TypedC](/docs/tutorial_oopsla2024.pdf)

This is the tutorial accompanying the prototype of our [OOPSLA 2024
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
