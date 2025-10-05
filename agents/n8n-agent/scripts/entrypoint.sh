#!/usr/bin/env bash
set -euo pipefail

# Default values if not provided
: "${N8N_MAIN_URL:=http://localhost:5678}"
: "${N8N_RUNNERS_LAUNCHER_HEALTH_CHECK_PORT:=5680}"
: "${N8N_RUNNERS_BROKER_PORT:=5679}"

if [[ -z "${N8N_RUNNERS_AUTH_TOKEN:-}" ]]; then
  echo "ERROR: N8N_RUNNERS_AUTH_TOKEN is required" >&2
  exit 1
fi

# Show minimal startup info
echo "Starting n8n task-runner launcher..."

echo "Main URL: ${N8N_MAIN_URL}"
echo "Launcher health: :${N8N_RUNNERS_LAUNCHER_HEALTH_CHECK_PORT}"

echo "Using config at /etc/n8n-task-runners.json"

# Start launcher with javascript runner. Python runner requires separate base and deps.
exec /usr/local/bin/task-runner-launcher javascript
