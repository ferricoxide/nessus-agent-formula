# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}

include:
  - {{ sls_config_clean }}

Delete Pre-Created Nessus Log Directory:
  file.absent:
    - name: '{{ nessus_agent.path_mods.real_nessus_log }}'

Delete Pre-Created Nessus Temp Directory:
  file.absent:
    - name: '{{ nessus_agent.path_mods.real_nessus_tmp }}'

Delete Sym-link To Log Dir:
  file.absent:
    - name: '{{ nessus_agent.nessus_root }}/var/nessus/logs'

Delete Sym-link To Temp Dir:
  file.absent:
    - name: '{{ nessus_agent.nessus_root }}/var/nessus/tmp'

Delete Nessus Agent Installation-root:
  file.absent:
    - name: '{{ nessus_agent.nessus_root }}'
    - require:
      - file: 'Delete Sym-link To Log Dir'
      - file: 'Delete Sym-link To Temp Dir'
