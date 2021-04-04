# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

testing
- all_items and all_merchants endpoints
  - happy path testing includes:
    - default params are page = 1 and per_page = 20
    - optional params work properly individually
    - optional params work properly in conjunction with each other
  - Edge case testing includes:
    - the endpoint returns everything if the per_page is grater the the available data
    - the endpoint returns a page with no objects if the page number is greater then available pages
    - it returns all remaining items if the last page is not equal to the per_page limit
  - Sad Path testing includes:
    - endpoint returns page 1 if page query param is less then 1
    - endpoint returns 20 items per page if per_page query param is less then 1
    - endpoint uses the default params for page and per_page if the query param is empty

- find_item (search) endpoint
  - happy path testing includes:
    - the endpoint returns the first item with a matching name sorted alphabetically (when the name query param is used)
    - the endpoint returns no object if there are no matches for the item name (when the name query param is used)
    - the endpoint returns the first item above or below the minimum or maximum value sorted alphabetically (when only one price query param is used)
    - the endpoint returns the first item between the maximum and minimum values sorted alphabetically (if both price query params are used)
  - Edge case testing includes:
    - the endpoint returns no item if the minimum value is greater then all items
    - the endpoint returns no item if the maximum value is less then all items
    - the endpoint returns no item if the maximum value is less then the minimum value
  - Sad path testing includes:
    - the endpoint returns a 400 response if both a name and price query param are give
    - the endpoint returns a 400 response if min max price query params are less then 0

- find_merchants (search) endpoint
  - Happy path testing includes:
    - the endpoint returns all merchants who match the name search params
    - the endpoint returns no objects if no merchants match the name search params
