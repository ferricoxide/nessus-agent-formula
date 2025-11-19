# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}

nessus-agent-package-install-pkg-installed:
  pkg.installed:
    - name: {{ nessus_agent.pkg.name }}

Pre-Create Nessus Log Directory:
  file.directory:
    - name: '{{ nessus_agent.real_nessus_log }}'
    - dir_mode: '0755'
    - group: root
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - user: root

Pre-Create Nessus Temp Directory:
  file.directory:
    - name: '{{ nessus_agent.real_nessus_tmp }}'
    - dir_mode: '0755'
    - group: root
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - user: root
