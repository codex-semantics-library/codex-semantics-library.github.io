---
title: Contact
layout: home
nav_order: 100
---

## Working on Codex

We often have *fully-funded* positions for talented and motivated research **interns**, **PhD students**, **postdocs** or **research engineers** that would like to work on the project. Depending on your skills and interests, we can propose you work on a variety of topics, such as (non-exhaustive list):
- sound static analysis by abstract interpretation (improving the heart of the analysis)
- compilation and code transformation (e.g., porting the analysis to new languages)
- applications to cybersecurity or reverse engineering (e.g., [verifying OS kernels from C or executable](/papers/2021-rtas-no-crash-no-exploit.html))
- utilisability and user interface (e.g., how to present information to make usage of the tool more productive)

Please contact us if you would like to join! CEA has as screening process that takes several months to complete, so do not hesitate to initiate contact early. 

CEA is part of Université Paris-Saclay and is located at the heart of Plateau de Saclay, south of Paris, Europe's biggest research and industry cluster. Agencies like [Science Accueil](https://www.science-accueil.org/en/) or [Cité Internationale Universitaire de Paris](https://www.ciup.fr/en/) are available to help foreign candidates find their home and settle here. Most of us live either in the wooden and quiet southern suburbs of Paris or closer to the bustling historical center of the city. Paris is the capital of France, a metropolis of 12.5 million people and one of the most visited travel destinations in the world, in the heart of western Europe.


## Using Codex

Codex is a tool that has a sound implementation based on a sound
theory, and that can already be useful in the following applications:

- Verification of memory safety of C or binary executable programs and
  libraries; verifying preservation of memory invariants with a low
  effort;
- Verification of absence of undefined behaviour of C programs, or runtime exceptions in binary executables;
- Verification of core security properties such as absence of
  privilege escalation, control-flow integrity, or memory safety in
  low-level code like OS kernels;
- Extraction of higher-level models from low-level code, including
  reverse engineering and decompilation.



While it has already been used on
[challenging](/papers/2021-rtas-no-crash-no-exploit.html)
[case](/papers/2024-oopsla-typedc-dependent-nominal-physical-type-system.html)
[studies](/papers/2022-vcmai-lightweight-shape-analysis.html), it is
still currently in beta state, meaning that is may not be as easy to
use as we would like to, that there may be some code features that are
not handled precisely enough, etc.

- **Early adopters** : we are eager to learn about your experience,
  suggestions of improvement for the tool, or even patches!
- **Industrial users** : please contact us if you would like us to adapt
  the tool to your need or provide support.

## Contact information

Contact <a href="mailto:{{ 'matthieu.lemerre@cea.fr' | encode_email }}">Matthieu Lemerre</a>, head of the Codex team at CEA.
