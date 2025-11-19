# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}

{%- set os_family = salt.grains.get('os_family') %}
{%- if os_family == 'Windows' %}
  {%- set nessus_package_name = salt.pillar.get(
    'nessus-agent:lookup:package_msi_url',
    []
  ) %}
{%- elif os_family == 'RedHat' %}
  {%- set nessus_package_name = salt.pillar.get(
    'nessus-agent:lookup:package_rpm_url',
    []
  ) %}
{%- endif %}

Nessus Agent Package-Install:
  pkg.installed:
    - sources:
      - {{ nessus_agent.pkg.name }}: {{ nessus_package_name }}
    - skip_verify: True
