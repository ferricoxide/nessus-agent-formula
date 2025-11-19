# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}

Create Sym-link To Log Dir:
  file.symlink:
    - name: '{{ nessus_agent.nessus_root }}/var/nessus/logs'
    - target: '{{ nessus_agent.path_mods.real_nessus_log }}'
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - require:
      - file: Pre-Create Nessus Log Directory

Create Sym-link To Temp Dir:
  file.symlink:
    - name: '{{ nessus_agent.nessus_root }}/var/nessus/tmp'
    - target: '{{ nessus_agent.path_mods.real_nessus_tmp }}'
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True
    - require:
      - file: Pre-Create Nessus Temp Directory

Pre-Create Nessus Log Directory:
  file.directory:
    - name: '{{ nessus_agent.path_mods.real_nessus_log }}'
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
    - name: '{{ nessus_agent.path_mods.real_nessus_tmp }}'
    - dir_mode: '0755'
    - group: root
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - user: root
