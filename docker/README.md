# Docker Configuration

This directory contains Docker-related configuration files for the Band Tour Management System.

## Structure

- `neo4j/`: Neo4j database configuration
  - `Dockerfile`: Custom Neo4j image with initialization script
  - `init-scripts/`: Scripts for Neo4j database initialization
    - `init.sh`: Shell script to initialize the database
    - `neo4j-init.cypher`: Cypher script with tour data model

## Neo4j Initialization

The Neo4j container includes an initialization script that will populate the database with tour data. However, due to timing issues with the Neo4j startup sequence, you may need to run the initialization script manually after the container has started:

```bash
# Start the containers
npm start

# Wait for Neo4j to fully start (about 10-15 seconds)

# Run the initialization script
docker exec build-an-ai-agent-hack-night-20250521-neo4j-1 /docker-entrypoint.d/20-init-db.sh
```

Alternatively, you can use the `start:clean` script which rebuilds all containers:

```bash
npm run start:clean
```

After initialization, you can verify the data was imported correctly:

```bash
docker exec build-an-ai-agent-hack-night-20250521-neo4j-1 cypher-shell -u neo4j -p bandtour2025 "MATCH (b:Band) RETURN b"
```
