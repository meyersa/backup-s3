FROM debian:bullseye-slim

LABEL maintainer="hleroy@hleroy.com"

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    cron \
    python3-setuptools \
    python3-pip \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# Install awscli
RUN pip3 install awscli

# Install MariaDB client
RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Add Postgres repository configuration
RUN echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > \
    /etc/apt/sources.list.d/pgdg.list

# Import the repository signing key
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null

# Install PostgreSQL client (default to version 13 if env var is not set)
ARG POSTGRES_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client-${POSTGRES_VERSION:-13} \
    && rm -rf /var/lib/apt/lists/*

# Copy scripts
COPY *.sh /
RUN chmod +x *.sh

ENTRYPOINT ["/start.sh"]
CMD [""]
