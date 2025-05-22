# Venue Data Enrichment Workflow

## Overview

This workflow enhances venue data for Wyatt Olney & The Wreckage's East Coast tour by gathering additional information from multiple data sources. It builds upon the basic venue data collected by the venue-research workflow and adds rich details to help with tour planning and logistics.

## Features

- **Yelp Integration**: Retrieves ratings, reviews, contact information, and business categories
- **Weather Forecast**: Gets weather predictions for the venue location
- **Nearby Amenities**: Identifies parking options, restaurants, and hotels near each venue
- **Data Persistence**: Stores all enriched data in Neo4j for easy access and visualization

## Prerequisites

Before running this workflow, you need:

1. A venue already added to Neo4j using the venue-research workflow
2. API keys for:
   - Yelp Fusion API
   - OpenWeatherMap API
   - Google Places API

## Usage

### Webhook Endpoint

POST to: `/webhook/enrich-venue`

### Request Parameters

```json
{
  "venueName": "Venue Name",
  "city": "City",
  "state": "State",
  "yelpApiKey": "YOUR_YELP_API_KEY",
  "weatherApiKey": "YOUR_OPENWEATHERMAP_API_KEY",
  "googleApiKey": "YOUR_GOOGLE_API_KEY"
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
   - Yelp API for business details
   - Weather API for forecast information
   - Google Places API for nearby parking
   - Google Places API for nearby restaurants
   - Google Places API for nearby hotels
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
