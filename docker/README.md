# Docker Configuration

This directory contains Docker-related configuration files for the Band Tour Management System.

## Structure

- `neo4j/`: Neo4j database configuration
  - `init-scripts/`: Scripts that run when the Neo4j container is initialized
    - `neo4j-init.cypher`: Cypher script to initialize the database with tour data

## Automatic Initialization

The Neo4j container is configured to automatically run scripts from the `init-scripts` directory when it first starts up.
