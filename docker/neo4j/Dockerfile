FROM neo4j:5.13.0

# Install curl for health check in init script
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy initialization script
COPY init-scripts/init.sh /docker-entrypoint.d/20-init-db.sh

# Make sure the script is executable with proper permissions
RUN chmod 755 /docker-entrypoint.d/20-init-db.sh
