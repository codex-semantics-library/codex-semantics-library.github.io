---
title: Home
layout: home
nav_order: 0
---

*Codex* is an OCaml library to help writing sound static analyses by
abstract interpretations, such as BINSEC/Codex (for analysis of
machine code using the [BINSEC](https://binsec.github.io) platform) or
Frama-C/Codex (for analysis of C code using the
[Frama-C](https://frama-c.com) platform).

To illustrate what Codex can do, here is the output of Codex for the `abs` function:

<iframe src="{{ '/assets/codexoutputs/abs.notypes.html' | relative_url }}" width="100%" height="400px" frameborder="1"
	style="border:1px solid #000; border-radius:15px; box-shadow: 0 3px 6px rgba(0,0,0,0.3);"></iframe>


You can hover on parts of the code above to see the possible values of
each expression. Observe that initially, the value of `x` is unknown
(is in the interval `[--..--]` meaning all the possible values), but
its value is refined after the `x<0` test in each branch. Codex
performs a sound analysis, meaning that the values attached to each
program variable is a superset of the real values in the program. In
other words, when we display that `x` is in the interval
`[0..0x7FFFFFFF]`, then we guarantee that `x` cannot be negative
there.

An important application of such analysis is to verify the absence of
runtime errors. It is easy, even for a seasoned C programmer, to fall
into one of the many pitfalls (undefined behaviour) of the C
programming language, be it well-known ones such as buffer overflows,
null pointer dereferences, and division by zero, or lesser known ones
like signed integer overflow or absence of compliance to the C strict
aliasing rules. Programs with these errors risk being miscompiled, to
crash, to silently corrupt some data, or be vulnerable to
cybersecurity attacks.

Codex can be used to automatically prove the absence of such defects,
or warn if it finds one. The seemingly simple `abs` function has such
a defect: the value `INT_MIN = -0x80000000` cannot be negated as
`0x80000000` cannot fit inside a `int` value. As a result, Codex
displays an alarm warning about this at the top right of the analysis
output (the list of alarms that Codex looks at is configurable).

This error only appears if `abs` is given the value `INT_MIN`, so we
may consider that the problem does not reside in the `abs`
implementation, but in any function that would fail to call `abs`
properly. Codex allows to encode such *contracts* between `abs` and
its callers using types specifications. For instance, a possible
contract for `abs` could be


```c
(int with self >= 0) abs((int with self >= 0-1000) x);
```

which states that if `abs` is provided with a value higher than -1000,
then `abs` returns a positive number. Observe the analysis output for
`abs` when provided with this contract: the error is now gone.

<iframe src="{{ '/assets/codexoutputs/abs.withtypes.html' | relative_url }}" width="100%" height="400px" frameborder="8"
	style="border:1px solid #000; border-radius:15px; box-shadow: 0 4px 8px rgba(0,0,0,0.3);"></iframe>


It is important to understand what "the error is gone" means. Codex is
not a heuristic bug finding tool (like compiler warnings), that may
miss some alarms. *The fact that the signed overflow alarm is not
displayed anymore is a proof that such an error cannot happen*. In
other words, Codex can automatically compute a proof of absence of
runtime errors; it can, for instance prove that a program is
memory-safe, or return a list of lines where there may be possible
errors. As an example, Codex has been used to verify absence of
privilege escalation (which includes proving memory safety or
control-flow integrity) of a small industrial embedded OS kernel,
directly from its executable (see
[here](papers/2021-rtas-no-crash-no-exploit.html) for more details).

The tool is currently a research prototype, but we believe that it
would be very useful to C or systems programmers, which is why we are
working on making it more mature (writing better documentation,
improving user interface, etc.). Stay tuned for future updates, or
just <a href="mailto:{{ 'matthieu.lemerre@cea.fr' | encode_email }}">contact us</a>
if you are interested or want to help!
