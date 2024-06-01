---
layout: default
parent: API
title: Patricia Tree
url: /api/patricia-tree/
redirect_from:
  - /patricia-tree/
  - /patricia-tree.html
---

# Patricia Tree API

{% include shields.html package=site.data.packages.patricia-tree %}

This is an [OCaml](https://ocaml.org/) library that implements sets and maps as
Patricia Trees, as described in Okasaki and Gill's 1998 paper
[*Fast mergeable integer maps*](https://www.semanticscholar.org/paper/Fast-Mergeable-Integer-Maps-Okasaki-Gill/23003be706e5f586f23dd7fa5b2a410cc91b659d).
It is a space-efficient prefix trie over the big-endian representation of
the key's integer identifier.

The source code of this library is available on [Github]("https://github.com/codex-semantics-library/patricia-tree)
under an [LGPL-2.1](https://choosealicense.com/licenses/lgpl-2.1/) license.

{: .note }
For a quick overview of how to use the library, see the [examples](/api/patricia-tree/{{ site.data.packages.patricia-tree.latest-version }}/#examples).

## Documentation versions

See any of these for more details on this library, what it can do, some
small examples and the full documentation.


- [patricia-tree – v0.10.0](/api/patricia-tree/v0.10.0/) – latest version
- [patricia-tree – v0.9.0](/api/patricia-tree/v0.9.0/)
- [patricia-tree – main](/api/patricia-tree/main/) – development version (unreleased)

Changes between versions are listed in the
[changelog](https://github.com/codex-semantics-library/patricia-tree/blob/main/CHANGELOG.md).

## Installation

This library can be installed with [opam](https://opam.ocaml.org/):
```bash
opam install patricia-tree
```

Alternatively, you can clone the source repository and compile with [dune](https://dune.build/):
```bash
git clone git@github.com:codex-semantics-library/patricia-tree.git
cd patricia-tree
opan install . --deps-only
dune build -p patricia-tree
dune install
# To build documentation
opam install . --deps-only --with-doc
dune build @doc
```
