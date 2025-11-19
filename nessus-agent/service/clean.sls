# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}

nessus-agent-service-clean-service-dead:
  service.dead:
    - name: {{ nessus_agent.service.name }}
    - enable: False
