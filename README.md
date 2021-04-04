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
- all_items endpoint
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
