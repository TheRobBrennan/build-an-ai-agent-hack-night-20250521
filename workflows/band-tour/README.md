# Band Tour Management System Workflows

## Overview

These workflows are part of the Band Tour Management System for Wyatt Olney & The Wreckage's East Coast Tour 2025. They provide functionality for venue research, fan engagement, and tour notifications.

## Prerequisites

1. n8n running (via Docker Compose)
2. Neo4j database running (via Docker Compose)
3. Twilio account with verified credentials

## Setup Instructions

1. Start the Docker containers:

   ```bash
   npm start
   ```

2. Access n8n at [http://localhost:5678](http://localhost:5678)

3. Import the workflow JSON files from this directory

4. Configure credentials:
   - Set up Neo4j credentials (default: neo4j/bandtour2025)
   - Add your Twilio API credentials

## Available Workflows

### 1. Twilio Notification

**File:** `twilio-notification.json`

Sends SMS/MMS notifications about tour updates, venue information, or gear checklists.

**Example POST request:**

```json
{
  "from": "+1234567890",  // Your Twilio number
  "to": "+0987654321",    // Recipient's number
  "message": "Don't forget to pack extra drumsticks for the Rock the Mountains show!",
  "mediaUrl": "https://example.com/image.jpg"  // Optional
}
```

### 2. Venue Research

**File:** `venue-research.json`

Researches venue information using Google Places API and stores it in Neo4j.

**Example POST request:**

```json
{
  "venueName": "Shrine",
  "city": "New York",
  "state": "NY",
  "apiKey": "your-google-places-api-key"
}
```

### 3. QR Code Generator

**File:** `qr-code-generator.json`

Generates QR codes for fan engagement, merchandise, or donations.

**Example POST request:**

```json
{
  "type": "merch",
  "venue": "Rock the Mountains Festival",
  "url": "https://wyattolney.bandcamp.com/merch",
  "description": "Exclusive festival merchandise"
}
```

## Neo4j Database

The tour data is stored in a Neo4j graph database. You can access the Neo4j browser at [http://localhost:7474](http://localhost:7474) (credentials: neo4j/bandtour2025).

To initialize the database with tour data, run the Cypher script in `/docs/neo4j-init.cypher`.

## Testing the Workflows

1. Start the workflows in n8n
2. Use a tool like Postman or curl to send POST requests to the webhook endpoints
3. Check the Neo4j database to verify the data is being stored correctly
