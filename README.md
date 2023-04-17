
# Punchy

## Description

Punchy is a punch card app for food trucks in San Francisco.

I wanted there to provide a way to interact with the data, and I came up with
punchcards. The idea is that food trucks can offer punch cards to their
customers on the app. The app uses the customer's location. When they are near
a food truck, a punch card for that food truck is displayed. Each punch card
bears a QR code that the food truck workers can scan to punch it.

The API lists locations where food truck will be. For some of the food trucks,
it specifies when the truck will be there. I will use the location data to
determine whether the truck is close. I won't use the time windows because very
few food trucks have that information.

I created the project as an umbrella app because I envisioned having separate
apps for the business logic and the mobile app. The mobile app likely wouldn't
be built with Elixir, and there wasn't enough time to build it either, so I only
built an app for the business logic, `apps/punchy_api`.

In a real production situation, this would run alongside and be utilized by the
other components.

```bash
git clone https://github.com/morgandonze/punchy.git
cd punchy && mix deps.get
```

Enter postgres database username, password into `config/dev.exs`

Run setup script to populate truck data.
```
cd apps/punchy_api
mix run priv/populate_trucks_operations.exs
```

This data come from the SF Food Truck dataset.


## Usage

### Functions

The key features are three functions:

* `PunchyApi.punch_cards_for_nearby_trucks(latitude, longitude)`: returns a
list of punch card data structs for nearby trucks, whether the user has any
punches or not.

Example:
`PunchyApi.punch_cards_for_nearby_trucks(37.794, -122.395)`

* `PunchyApi.users_punch_cards(user_id)`: returns a list of punch cards for the user
with one or more punches. (not implemented yet)

* `PunchyApi.punch_punch_card(truck_id, user_id)`: Adds a punch to the punch
card. Returns the updated punch card struct, or an empty array if the new punch
completes the card. The food truck should then give the customer their reward.

Example:
`PunchyApi.punch_punch_card(106, 1)`

### Testing

Use IEx to try out these methods.

`iex -S mix`


# Dev Notes

Food Truck API:
https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data

Food Truck latest data CSV url:
https://data.sfgov.org/api/views/rqzj-sfat/rows.csv

database port: 5432

**Resources**

`Users`
id: ID
username: string

has one Truck
has many PunchCards

`Trucks`
id: ID
name: string (Applicant in dataset)
card_punches_needed: integer
card_image: text (link to image on CDN, ideally)
card_completion_reward: text

belongs to User
has many PunchCards
has many Operations

`Operations`

(A time window in which a Truck will be operating)

truckId: references:trucks
dayOfWeek: string
startTime: datetime
endTime: datetime
latitude: string (WGS84)
longitude: string (WGS84)
menu: text (optionaltext in the dataset)

belongs to Truck

`PunchCards`
user_id: ID
truck_id: ID
num_punches: integer

belongs to User
belongs to Truck

I have already created the umbrella project.

Next, to create Punchy API using `mix new punchy_api`

Added Repo to Punchy API with postgrex and ecto_sql.

Added models (Users, Trucks, etc)

Creating User module

Add changeset function on User module

PunchyAPI method get_operations_near_place_time

I'll use a simple rule for determining which locations are nearby. The
circumference of the earth along the equator is about 25,000 miles, and there
are 360 degrees in a circle. Dividing these, we see that one degree longitude
is about 69.4 miles.

I want to populate the Operations now. I'll use
[NimbleCSV](https://hexdocs.pm/nimble_csv/NimbleCSV.html) to parse the CSV file.

I added this url to PunchyAPI's config.

Population script is complete.

Working on get_nearby_operations.
