#!/bin/bash

# Wait for Neo4j to be available
echo "Waiting for Neo4j to be available..."
until curl -s -o /dev/null http://localhost:7474; do
  sleep 1
done

echo "Neo4j is available, initializing database..."

# Run the Cypher initialization script
cat /var/lib/neo4j/import/init-scripts/neo4j-init.cypher | cypher-shell -u neo4j -p bandtour2025

echo "Database initialization complete!"
