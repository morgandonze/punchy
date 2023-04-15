
# Todo

## General

- [x] Create Punchy API
- [ ] Create Customer App
- [ ] Create Operator App

- [ ] Test that I can use PunchyAPI from PunchyWeb (custmer app)

## Setup & Deployment

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
    - [ ] Group by truck_id
  - [ ] Punch PunchCard

## PunchyWeb (Customer App)

- [ ] PunchCard list screen
  - [ ] Call get active Operations near locations endpoint to populate list
  - [ ] Display QR code to send `punch_card_id` indicating which PunchCard to punch

## Operator App

- [ ] Main screen
  - [ ] QR code scanner display
  - [ ] Short instructions to scan QR code on customer's app
  - [ ] When code is scanned, use `Punch PunchCard` endpoint with `punch_card_id`


