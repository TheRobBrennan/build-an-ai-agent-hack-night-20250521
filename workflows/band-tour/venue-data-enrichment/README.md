# Venue Data Enrichment Workflow

## Overview

This workflow enhances venue data for Wyatt Olney & The Wreckage's East Coast tour by gathering additional information from multiple public data sources. It builds upon the basic venue data collected by the venue-research workflow and adds rich details to help with tour planning and logistics, all without requiring any API keys.

## Features

- **Wikipedia Integration**: Retrieves general information about venues and locations
- **OpenStreetMap Data**: Gets detailed location information and area details
- **Nearby Amenities**: Identifies parking options, restaurants, and hotels near each venue
- **Data Persistence**: Stores all enriched data in Neo4j for easy access and visualization

## Prerequisites

Before running this workflow, you need:

1. A venue already added to Neo4j using the venue-research workflow
2. Neo4j database connection (included in the project setup)

## Complete Setup Walkthrough

### Step 1: Start n8n

```bash
# Navigate to your project directory
cd build-an-ai-agent-hack-night-20250521

# Start n8n using Docker Compose
npm start
```

This will start n8n at [http://localhost:5678](http://localhost:5678). Log in with your credentials.

### Step 2: Set Up HTTP Basic Auth for Neo4j

Our workflow uses HTTP Basic Auth to connect to Neo4j's REST API:

1. In n8n, click on the **Settings** icon in the left sidebar
2. Go to **Credentials**
3. Click **Create New Credentials**
4. Select **HTTP Basic Auth**
5. Fill in the following details:
   - **Credential Name**: Neo4j HTTP Auth
   - **User**: neo4j
   - **Password**: bandtour2025 (from your docker-compose.yml)
6. Click **Save**

### Step 3: Import the Workflow

1. In n8n, go to **Workflows** in the left sidebar
2. Click **Import from File**
3. Select the `workflow.json` file from this directory
4. Click **Import**

### Step 4: Configure the Workflow

1. In the imported workflow, click on each HTTP Request node that connects to Neo4j
2. Make sure the HTTP Basic Auth credential is selected (should be auto-selected if named "Neo4j HTTP Auth")
3. Click **Save** to save the workflow

### Step 5: Activate the Workflow

1. Click the **Active** toggle switch in the top-right corner
2. Confirm activation

### Step 6: Test the Workflow

#### Option 1: Using curl

```bash
curl -X POST http://localhost:5678/webhook/enrich-venue \
  -H "Content-Type: application/json" \
  -d '{
    "venueName": "Shrine",
    "city": "New York",
    "state": "NY"
  }'
```

#### Option 2: Using Postman

1. Create a new POST request to `http://localhost:5678/webhook/enrich-venue`
2. Set the content type to `application/json`
3. Add the following JSON in the request body:

   ```json
   {
     "venueName": "Shrine",
     "city": "New York",
     "state": "NY"
   }
   ```

4. Click **Send**

### Step 7: View Results

1. In n8n, go to **Executions** in the left sidebar
2. Find your workflow execution
3. Click to view details
4. You can see the data at each step of the process

### Step 8: Verify Data in Neo4j

1. Open your Neo4j browser (typically at [http://localhost:7474](http://localhost:7474))
2. Run the following Cypher query:

   ```cypher
   MATCH (v:Venue {name: "Shrine", city: "New York", state: "NY"}) RETURN v
   ```

3. You should see the venue with all the enriched data

## Usage

### Webhook Endpoint

POST to: `/webhook/enrich-venue`

### Request Parameters

```json
{
  "venueName": "Venue Name",
  "city": "City",
  "state": "State"
}
```

### Response

```json
{
  "success": true,
  "message": "Venue data enriched successfully",
  "data": {
    // Enriched venue data
  }
}
```

## Workflow Steps

1. Receive webhook request with venue details
2. Check if venue exists in Neo4j database
3. If venue exists, gather data from:
   - Wikipedia API for general venue and location information
   - OpenStreetMap Nominatim API for geocoding and location details
   - OpenStreetMap Nominatim API for area details
   - OpenStreetMap Nominatim API for nearby parking
   - OpenStreetMap Nominatim API for nearby hotels
   - OpenStreetMap Nominatim API for nearby restaurants
4. Process and format all collected data
5. Update the venue record in Neo4j
6. Return success response with enriched data

## Integration with Other Workflows

This workflow is designed to work alongside:

- **Venue Research Workflow**: Run venue-research first to create the basic venue record
- **Twilio Notification Workflow**: Can be triggered after this workflow to notify team members about venue details
- **QR Code Generator**: Can use venue data to create custom QR codes for each show

## Error Handling

If the venue is not found in the database, the workflow will return an error message suggesting to run the venue-research workflow first.
