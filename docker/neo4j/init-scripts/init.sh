#!/bin/bash
set -e

echo "[$(date)] Starting Neo4j initialization script..."

# Check if the Cypher script exists
if [ ! -f /var/lib/neo4j/import/init-scripts/neo4j-init.cypher ]; then
  echo "[$(date)] ERROR: Neo4j initialization Cypher script not found!"
  echo "Expected location: /var/lib/neo4j/import/init-scripts/neo4j-init.cypher"
  echo "Current directory content:"
  ls -la /var/lib/neo4j/import/init-scripts/
  exit 1
fi

# Wait for Neo4j to be available (up to 120 seconds)
echo "[$(date)] Waiting for Neo4j to be available..."
for i in {1..120}; do
  echo "[$(date)] Attempt $i/120: Checking if Neo4j is available..."
  if curl -s -o /dev/null http://localhost:7474; then
    echo "[$(date)] Neo4j is available!"
    
    # Sleep a bit more to ensure Neo4j is fully ready
    echo "[$(date)] Waiting 10 seconds for Neo4j to be fully ready..."
    sleep 10
    
    # Run the Cypher initialization script
    echo "[$(date)] Running Cypher initialization script..."
    cat /var/lib/neo4j/import/init-scripts/neo4j-init.cypher | cypher-shell -u neo4j -p bandtour2025
    
    if [ $? -eq 0 ]; then
      echo "[$(date)] Database initialization completed successfully!"
      exit 0
    else
      echo "[$(date)] ERROR: Database initialization failed!"
      exit 1
    fi
  fi
  sleep 1
done

echo "[$(date)] ERROR: Timed out waiting for Neo4j to become available. Will not initialize database."
exit 1
