---
layout: paper
parent: Publications
title:  "PLDI'25"
categories: new publication
date: 2025-06-15
nav_order: 2025-06-15
katex: True
---

## Context

In program analysis, various abstractions are used to store known facts about the
program being studied. Two popular choices are *non-relational abstractions*,
which store numeric information on variables (like intervals $$x \in [0:5]$$), or *relational
abstraction*, which store relations between variables (like $$3x + 2y \leqslant -5z$$).
The former is fast (complexity in $$\mathcal O(|\mathbb X|)$$ where $$|\mathbb X|$$ is the number of variables)
but imprecise, whereas the latter is very precise but cost-prohibitive
(polyhedra has $$\mathcal O(2^{|\mathbb X|})$$ complexity).

In the middle of this spectrum lie *weakly-relational abstractions*. They only
store a select few relations between pairs of variables. For example, octagons
store relations $$\pm x \pm y \leqslant c$$. These abstractions are faster than
full relational domains, but still expensive, in large part due to having to compute
a transitive closure to find all known relations, which costs $$\mathcal O(|\mathbb X|^3)$$.

Thus, the central assumption of the paper can be expressed as **what if we do not need to compute
this transitive closure?** More formally, we assume that the relation obtained on each path between
two variables is always the same. This allows eliminating the vast majority of relations, **we only need to
store a spanning tree** and can still recover any arbitrary relation in constant time.

<img src="/assets/publications/imgs/2025-pldi-spanning-tree.svg"
style="width:700px; display:block; margin-left:auto; margin-right:auto">

<center>
Fig. Graph of relations between variables. Each arrow represents a relation, labels have been omitted.
Left is the initial configuration, middle is the computed closure, and right is a minimal spanning tree
</center>


## Contributions

### Labeled union-find

We extend the classical [union-find](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) data
structure by adding labels $$\mathbb L$$ (representing relations) to the parent edges. In order to
properly adapt the union-find algorithms, these labels need an associative composition operation
$$\mathbb ;$$, an inverse $$\cdot^{-1}$$ and a neutral element. That is to say, they must have a
[**group structure**](https://en.wikipedia.org/wiki/Group_(mathematics)). This requirement also
derives fairly naturally from our previous assumption (same relation on each path).

<img src="/assets/publications/imgs/2025-pldi-labeled-uf.svg"
style="width:500px; display:block; margin-left:auto; margin-right:auto">
<center>
Fig. Main operation of labeled union-find. Compared to classical union-find,
the "union" operation has been renamed "add_relation", and the get_relation operation
is new.
</center>

### The labeled union-find relational abstraction

When using labeled union-find to represent abstract relations between variables,
the soundness of operations places strong requirements on the relations that
can be used. We show that these relations **must correspond to injective functions**
between equivalence classes. The following examples relations are suitable:

- Constant offset: relations of the form $$y = x + b$$ for some constant $$b$$
- Two Value per Equality (TVPE): $$ax + by + c = 0$$, with $$a,b,c \in \mathbb Z^3$$, $$\mathbb Q^3$$ or $$\mathbb R^3$$
- Modular TVPE: $$y = ax + b\mathop{\texttt{mod}} 2^{64}$$ between 64-bit vectors with $$a$$ odd.
- Xor and rotation: $$y = (x \mathop{\mathtt{xor}} c) \mathop{\mathtt{rot}} n$$ between fixed-size bitvector, which can encode many shifts

However, we cannot use relations like bounded difference $$y - x \in [a:b]$$, as
they are not injective. Doing so inevitably leads to precision loss.

### Combining with other abstractions

Labeled union-find groups variables into related class, which each point to the
same representative. This can often be used to simplify other abstractions,
especially whenever information on any element can be deduced from information
on the representative.

For example, when combining the constant offset labeled union-find with the interval abstraction, we
only need to store intervals on representative elements, not on all variables, since these can be
recovered. If we know that $$y \xrightarrow{+2} x$$ and $$x \in [0:2]$$ then we do not need to store
$$y \in [2:4]$$. This reduces storage cost and propagation time, since all related variables are
updated at once any time new information is learned.

Labeled union-find can also help relational abstraction similarly, shrinking their size and thus their
computation cost. Furthermore, it can be modified to detect any entailed equalities and notify other
abstractions of these facts.

## Going further

- Read the [**paper**](/assets/publications/pdfs/2025-pldi-relational-abstractions-labeled-uf-with-appendices.pdf).
- You can also read the [**WIP workshop paper**](https://hal.science/cea-04996700v1). It is only 4 pages long and less technical.
- To be presented at the [Programming Language Design and Implementation (PLDI) 2025 conference](https://pldi25.sigplan.org/).
- Download the [**software artifact**](https://zenodo.org/records/15261356) from
  Zenodo to explore the code and see the performance results.
