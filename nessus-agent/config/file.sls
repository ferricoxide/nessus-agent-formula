# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as nessus_agent with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

nessus-agent-config-file-file-managed:
  file.managed:
    - name: {{ nessus_agent.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='nessus-agent-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ nessus_agent.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        nessus_agent: {{ nessus_agent | json }}
