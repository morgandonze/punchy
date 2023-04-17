# Todo

## General

- [x] Create Punchy API
- [ ] Way to select a user (who's punch card to punch?)
- [ ] Answer, why an umbrella project?
- [ ] Test that I can use PunchyAPI from PunchyWeb (custmer app)

## Setup & Deployment
- [ ] Describe docker setup

- [ ] Answer question: How would you actually deploy this to production?
- [X] Seeds file
  - [X] Create food truck owner users

## Punchy API

- [x] Add Ecto Repo

- [x] Create models
  - [x] Users
  - [x] Trucks
  - [x] Operations
  - [x] UserPunchCards

- [ ] Populate list of Operations
  `apps/punchy_api/priv/populate_trucks_operations.exs`
  - [X] Create Operation for each row
  - [X] Create new Truck for Operation when needed
  - [X] Create new User for Truck when needed

- [X] Core Business Methods
  - [X] Get active Operations near location
    - [X] Group by truck_id
      - [ ] Use an `IN [truck_ids]` SQL query to make one request for all the trucks
  - [X] Get users punch cards method
  - [X] Punch PunchCard method


