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

Thus, the central assumption of the paper can be expressed as **what if we do not need to compute this
transitive closure?** More formally, we assume that the relation obtained on each
path between two variables is the same. This allows eliminating the vast majority
of relations, **we only need to store a spanning tree** and can still recover
any arbitrary relation in constant time.

## Extending union-find

The [union-find](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) data
structure is a well-known extremely efficient way to build and query equivalence
relations. As such, it is often used in program analysis to represent equality
between variables or expressions, notably in
[e-graphs](https://en.wikipedia.org/wiki/E-graph).

Our work presents an extension of union-find to represent more complex relations
than equality. This can be done by labeling the parent pointers of union-find
with a relation. For example, we can use the constant offset relation

Crucially, we show that

## A cheap relational domain
