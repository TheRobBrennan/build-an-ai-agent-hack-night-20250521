// Initialize Neo4j database for Wyatt Olney & The Wreckage East Coast Tour

// Clear existing data (be careful with this in production!)
MATCH (n) DETACH DELETE n;

// Create Band node
CREATE (band:Band {
  name: "Wyatt Olney & The Wreckage",
  genre: "Hard Rock",
  homeCity: "Seattle",
  website: "https://www.wyattolneyandthewreckage.com"
});

// Create Tour node
CREATE (tour:Tour {
  name: "East Coast Tour 2025",
  startDate: "2025-07-24",
  endDate: "2025-08-04"
});

// Create relationship between Band and Tour
MATCH (b:Band {name: "Wyatt Olney & The Wreckage"}), (t:Tour {name: "East Coast Tour 2025"})
CREATE (b)-[:PERFORMING]->(t);

// Create Transportation nodes
CREATE (flight1:Transportation {
  type: "Flight",
  carrier: "Alaska Airlines",
  flightNumber: "AS 378",
  departureCity: "Seattle",
  departureAirport: "SEA",
  departureTime: "2025-07-24T10:03:00",
  arrivalCity: "Baltimore",
  arrivalAirport: "BWI",
  arrivalTime: "2025-07-24T18:08:00"
});

CREATE (flight2:Transportation {
  type: "Flight",
  carrier: "Alaska Airlines",
  flightNumber: "AS 379",
  departureCity: "Baltimore",
  departureAirport: "BWI",
  departureTime: "2025-08-04T19:10:00",
  arrivalCity: "Seattle",
  arrivalAirport: "SEA",
  arrivalTime: "2025-08-04T22:00:00"
});

CREATE (van:Transportation {
  type: "Van",
  description: "Fan-driven gear transport",
  departureCity: "Seattle",
  arrivalCity: "Baltimore",
  notes: "Two fans driving gear cross-country"
});

// Create Venue nodes
CREATE (rtm:Venue {
  name: "Rock the Mountains Festival",
  city: "Cumberland",
  state: "MD",
  website: "https://ticketbud.com/events/4793d608-d5b1-11ef-8048-42010a71703b",
  capacity: 8000,
  notes: "Large outdoor festival"
});

CREATE (sbg:Venue {
  name: "Simple Bar and Grill",
  city: "Washington",
  state: "DC",
  notes: "First time playing this venue"
});

CREATE (fire:Venue {
  name: "The Fire",
  city: "Philadelphia",
  state: "PA",
  notes: "First time playing this venue"
});

CREATE (coc:Venue {
  name: "Cumberland Outdoor Club",
  city: "Cumberland",
  state: "MD",
  notes: "First time playing this venue"
});

CREATE (shrine:Venue {
  name: "Shrine",
  city: "New York",
  state: "NY",
  website: "https://www.shrinenyc.com",
  notes: "First time playing this venue"
});

CREATE (rockshack:Venue {
  name: "The Rock Shack",
  city: "Somerville",
  state: "NJ",
  notes: "First time playing this venue"
});

CREATE (cobra:Venue {
  name: "Cobra Club",
  city: "New York",
  state: "NY",
  website: "https://www.cobraclubbk.com",
  notes: "First time playing this venue"
});

// Create Show nodes and connect to venues
CREATE (show1:Show {
  date: "2025-07-25",
  time: "TBD",
  type: "VIP Performance",
  notes: "VIP tent performance"
});

CREATE (show2:Show {
  date: "2025-07-26",
  time: "TBD",
  type: "Festival Performance",
  notes: "Main stage performance"
});

CREATE (show3:Show {
  date: "2025-07-27",
  time: "TBD",
  type: "Club Show",
  notes: "Evening show"
});

CREATE (show4:Show {
  date: "2025-07-29",
  time: "TBD",
  type: "Club Show",
  notes: "Evening show"
});

CREATE (show5:Show {
  date: "2025-07-30",
  time: "TBD",
  type: "Club Show",
  notes: "Evening show"
});

CREATE (show6:Show {
  date: "2025-07-31",
  time: "TBD",
  type: "Club Show",
  notes: "Evening show"
});

CREATE (show7:Show {
  date: "2025-08-01",
  time: "TBD",
  type: "Club Show",
  notes: "Evening show"
});

CREATE (show8:Show {
  date: "2025-08-02",
  time: "TBD",
  type: "Club Show",
  notes: "Evening show"
});

// Connect Shows to Venues
MATCH (s:Show {date: "2025-07-25"}), (v:Venue {name: "Rock the Mountains Festival"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-07-26"}), (v:Venue {name: "Rock the Mountains Festival"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-07-27"}), (v:Venue {name: "Simple Bar and Grill"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-07-29"}), (v:Venue {name: "The Fire"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-07-30"}), (v:Venue {name: "Cumberland Outdoor Club"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-07-31"}), (v:Venue {name: "Shrine"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-08-01"}), (v:Venue {name: "The Rock Shack"})
CREATE (s)-[:AT]->(v);

MATCH (s:Show {date: "2025-08-02"}), (v:Venue {name: "Cobra Club"})
CREATE (s)-[:AT]->(v);

// Connect Shows to Tour
MATCH (s:Show), (t:Tour {name: "East Coast Tour 2025"})
CREATE (t)-[:INCLUDES]->(s);

// Create Gear Category nodes
CREATE (drums:GearCategory {name: "Drums"});
CREATE (guitars:GearCategory {name: "Guitars"});
CREATE (amps:GearCategory {name: "Amplifiers"});
CREATE (merch:GearCategory {name: "Merchandise"});
CREATE (misc:GearCategory {name: "Miscellaneous"});

// Create some example Gear items
CREATE (drumKit:Gear {name: "Drum Kit", description: "Complete drum kit", weight: 100});
CREATE (snare:Gear {name: "Snare Drum", description: "Main snare", weight: 15});
CREATE (cymbals:Gear {name: "Cymbal Set", description: "Complete cymbal set", weight: 30});

CREATE (guitar1:Gear {name: "Electric Guitar 1", description: "Main electric guitar", weight: 10});
CREATE (guitar2:Gear {name: "Electric Guitar 2", description: "Backup electric guitar", weight: 10});
CREATE (bass:Gear {name: "Bass Guitar", description: "Bass guitar", weight: 12});

CREATE (guitarAmp:Gear {name: "Guitar Amp", description: "Main guitar amplifier", weight: 40});
CREATE (bassAmp:Gear {name: "Bass Amp", description: "Bass amplifier", weight: 45});

CREATE (tshirts:Gear {name: "T-Shirts", description: "Band t-shirts for sale", weight: 25});
CREATE (cds:Gear {name: "CDs", description: "Albums for sale", weight: 15});
CREATE (posters:Gear {name: "Posters", description: "Band posters for sale", weight: 10});

// Connect Gear to Categories
MATCH (g:Gear {name: "Drum Kit"}), (c:GearCategory {name: "Drums"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Snare Drum"}), (c:GearCategory {name: "Drums"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Cymbal Set"}), (c:GearCategory {name: "Drums"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Electric Guitar 1"}), (c:GearCategory {name: "Guitars"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Electric Guitar 2"}), (c:GearCategory {name: "Guitars"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Bass Guitar"}), (c:GearCategory {name: "Guitars"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Guitar Amp"}), (c:GearCategory {name: "Amplifiers"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Bass Amp"}), (c:GearCategory {name: "Amplifiers"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "T-Shirts"}), (c:GearCategory {name: "Merchandise"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "CDs"}), (c:GearCategory {name: "Merchandise"})
CREATE (g)-[:BELONGS_TO]->(c);

MATCH (g:Gear {name: "Posters"}), (c:GearCategory {name: "Merchandise"})
CREATE (g)-[:BELONGS_TO]->(c);

// Connect all Gear to the Tour (all gear is needed for the tour)
MATCH (g:Gear), (t:Tour {name: "East Coast Tour 2025"})
CREATE (t)-[:REQUIRES]->(g);

// Create some example queries to test the data model

// Query 1: Get all shows on the tour with venues
// MATCH (t:Tour {name: "East Coast Tour 2025"})-[:INCLUDES]->(s:Show)-[:AT]->(v:Venue)
// RETURN s.date as Date, v.name as Venue, v.city as City, v.state as State
// ORDER BY s.date;

// Query 2: Get all gear needed for the tour by category
// MATCH (t:Tour {name: "East Coast Tour 2025"})-[:REQUIRES]->(g:Gear)-[:BELONGS_TO]->(c:GearCategory)
// RETURN c.name as Category, collect(g.name) as Gear;

// Query 3: Get transportation details
// MATCH (t:Transportation)
// RETURN t.type as Type, t.departureCity as From, t.arrivalCity as To, 
//        CASE WHEN t.type = 'Flight' THEN t.flightNumber ELSE '' END as FlightNumber;
