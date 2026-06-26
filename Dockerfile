# ── Base Image ──────────────────────────────
# Start with Amazon Linux 2023
# (same OS as your EC2 — familiar!)
FROM amazonlinux:2023

# ── Metadata ────────────────────────────────
LABEL maintainer="Mainak Biswas <biswas199716@gmail.com>"
LABEL description="Server Health Monitor"
LABEL version="1.0"

# ── Install Dependencies ─────────────────────
# Install tools our script needs
RUN dnf install -y \
    bc \
    procps \
    hostname \
    && dnf clean all

# ── Set Working Directory ────────────────────
# All commands run from here
WORKDIR /app

# ── Copy Script ──────────────────────────────
# Copy health_check.sh from EC2 into container
COPY health_check.sh .

# ── Make Script Executable ───────────────────
RUN chmod +x health_check.sh

# ── Run Command ──────────────────────────────
# What happens when container starts
CMD ["./health_check.sh"]
