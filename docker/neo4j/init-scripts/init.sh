#!/bin/bash

# This script will be executed when the Neo4j container starts
# It will initialize the database with tour data

# Wait for Neo4j to be available (up to 60 seconds)
echo "Waiting for Neo4j to be available..."
for i in {1..60}; do
  if curl -s -o /dev/null http://localhost:7474; then
    echo "Neo4j is available, initializing database..."
    
    # Sleep a bit more to ensure Neo4j is fully ready
    sleep 5
    
    # Run the Cypher initialization script
    cat /var/lib/neo4j/import/init-scripts/neo4j-init.cypher | cypher-shell -u neo4j -p bandtour2025
    
    echo "Database initialization complete!"
    exit 0
  fi
  sleep 1
done

echo "Timed out waiting for Neo4j to become available. Will not initialize database."
exit 1
