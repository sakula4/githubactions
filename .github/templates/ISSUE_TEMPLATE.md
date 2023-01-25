---
title: Deployment triggered in {{ env.ENVIRONMENT }}-{{ env.REGION }} by {{ payload.sender.login }}
assignees: sakula4
labels: test
---
Someone just pushed, oh no! Here's who did it: {{ payload }}.
Workflow Run Link - {{ payload.repository.url }}/actions/runs/{{ payload.RUN_ID }}
