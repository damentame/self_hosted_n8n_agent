# Minimal image for n8n task-runner launcher with Node runtime available
FROM node:20-bookworm-slim

ARG USER=appuser
ARG UID=10001

# Install runtime deps: ca-certificates, curl, bash, tini
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl bash tini \
  && rm -rf /var/lib/apt/lists/*

# Create non-root user and directories
RUN useradd -m -u ${UID} -s /usr/sbin/nologin ${USER}

WORKDIR /app

# Copy launcher binary and scripts/config
COPY bin/task-runner-launcher /usr/local/bin/task-runner-launcher
COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/n8n-task-runners.json /etc/n8n-task-runners.json

# Ensure permissions
RUN chmod +x /usr/local/bin/task-runner-launcher /entrypoint.sh \
  && chown -R ${USER}:${USER} /app /etc/n8n-task-runners.json

# Healthcheck for launcher
HEALTHCHECK --interval=30s --timeout=3s CMD curl -sf http://127.0.0.1:${N8N_RUNNERS_LAUNCHER_HEALTH_CHECK_PORT:-5680}/healthz || exit 1

USER ${USER}

EXPOSE 5680

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/entrypoint.sh"]
