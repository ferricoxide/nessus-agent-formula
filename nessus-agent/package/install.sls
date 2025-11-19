# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}

nessus-agent-package-install-pkg-installed:
  pkg.installed:
    - name: {{ nessus_agent.pkg.name }}
