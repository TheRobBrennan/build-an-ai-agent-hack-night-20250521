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
