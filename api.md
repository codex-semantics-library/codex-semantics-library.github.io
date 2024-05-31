---
layout: default
# This title (API) and path (api) is hard-coded in all children (key parent: API)
# and in all grandchildren (_layouts/odoc.html in the breadcrumbs)
title: API
has_children: true
has_toc: false
nav_order: 20
---

# Packages

Codex includes the following ocaml packages.

{% for p in site.data.packages %}
{% assign package = p[1] %}
## {{ package.name }}

{: style="margin-bottom: 0.4rem;"}
{{ package.description }}


{% include shields.html package=package %}

<div class="linkrow">
{%- if package.repository -%}
<a href="{{package.repository}}">
{% if package.repository-icon %}<i class="{{ package.repository-icon }}"></i>{% endif %}
Repository</a>
{%- endif -%}
<a href="/api/{{ p[0] }}/{{ package.latest-version }}"><i class="fa fa-book"></i> Documentation (latest version)</a>
<a href="/api/{{ p[0] }}/"><i class="fa fa-book"></i> Documentation (all versions)</a>
</div>
{% endfor %}
