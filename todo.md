
# Todo

## General

- [x] Create Punchy API
- [ ] Create Customer App
- [ ] Create Operator App

## Deployment

- [ ] Answer question: How would you actually deploy this to production?

## Punchy API

- [x] Add Ecto Repo

- [ ] Create models
  - [x] Users
  - [x] Trucks
  - [x] Operations
  - [x] UserPunchCards

- [ ] Endpoints
  - [ ] Get active Operations near location
  - [ ] Punch PunchCard

## Customer App

- [ ] PunchCard list screen
  - [ ] Call get active Operations near locations endpoint to populate list
  - [ ] Display QR code to send `punch_card_id` indicating which PunchCard to punch

## Operator App

- [ ] Main screen
  - [ ] QR code scanner display
  - [ ] Short instructions to scan QR code on customer's app
  - [ ] When code is scanned, use `Punch PunchCard` endpoint with `punch_card_id`


