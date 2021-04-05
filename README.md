# Rails Engine API

###### Auther: [Doug Welchons](https://github.com/DougWelchons)


Rails engine is designed to simulate the backend portion of a internet sales platform,
providing to the front end program (not a part of this project), API endpoints to relevant data in the database.

<div style="display: inline-block">
This project was built with:<br>
* Ruby version 2.5.3<br>
* Rails version 5.2.5
</div>

<div style="display: inline-block">
This project was tested with:<br>
* RSpec version 3.10
</div>
<div style="content: ""; clear: both; display: table"></div>


#### Contents
- [Database](#database-creation)
- [Endpoint documentation](#endpoint-documentation)
  - [All items](#all-items)
  - [All merchants](#all-merchants)
  - [Find item](#find-item)
  - [Find merchants](#find-merchants)
  - [Merchants by revenue](#Merchants-by-revenue)
  - [Merchants by items sold](#merchants-by-items-sold)
  - [Items by revenue](#items-by-revenue)
  - [Unshipped invoices by potential revenue](#unshipped-invoices-by-potential-revenue)
- [Testing](#testing)
  - [Running tests](#running-tests)
  - [Tests for each endpoint](#tests-for-each-endpont)
    - [All_items](#all_items-endpoints)
    - [All_merchants](#all_merchants-endpoints)



* Configuration

* Database creation

In order to run this program locally you will need to create and seed a local database you can do so with `$ rails db:{drop,create,migrate,seed}`, or if you prefer to execute the commands manually one at a time, you can use the following

```
$ rails db:drop
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

### Endpoint Documentation
###### All items
- this endpoint returns a list of 
###### All merchants
###### Find item
###### Find merchants
###### Merchants by revenue
###### Merchants by items sold
###### Items by revenue
###### Unshipped invoices by potential revenue

* ...

### Testing
##### Running tests
- you can run the entire test suite with `bundle exec rspec`
- you can run an individual test suite with `bundle exec rspec <file path>` for example: `bundle exec rspec spec/requests/all_items_spec.rb`
- you can run an individual test or an entier describe block with `bundle exec rspec <file path>:<line number>` where the `<line number>` is the line a the test or describe block starts on


#### Tests for each endpoint
##### All_items endpoints
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

##### All_merchants endpoints
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

##### Find_item (search) endpoint
- happy path testing includes:
  - The endpoint returns the first item with a matching name sorted alphabetically (when the name query param is used)
  - The endpoint returns no object if there are no matches for the item name (when the name query param is used)
  - The endpoint returns the first item above or below the minimum or maximum value sorted alphabetically (when only one price query param is used)
  - The endpoint returns the first item between the maximum and minimum values sorted alphabetically (if both price query params are used)
- Edge case testing includes:
  - The endpoint returns no item if the minimum value is greater then all items
  - The endpoint returns no item if the maximum value is less then all items
  - The endpoint returns no item if the maximum value is less then the minimum value
- Sad path testing includes:
  - The endpoint returns a 400 response if both a name and price query param are give
  - The endpoint returns a 400 response if min max price query params are less then 0

##### Find_merchants (search) endpoint
- Happy path testing includes:
  - The endpoint returns all merchants who match the name search params
  - The endpoint returns no objects if no merchants match the name search params

##### Merchants_by_revenue endpoint
- Happy path testing includes:
  - The endpoint returns merchants equal to the quantity query params
  - The endpoint returns all merchants if the quantity query params is larger then the number of merchants
- Edge case testing includes:
  - The endpoint does not includes merchants that do not have any successful transactions
- Sad path testing includes:
  - The endpoint returns a 400 response if the quantity query param is less then 1
  - The endpoint returns a 400 response if the quantity query param is a string
  - The endpoint returns a 400 response if the quantity query param is blank
  - The endpoint returns a 400 response if the quantity query param is not provided

##### Merchants_by_items_sold endpoint
- Happy path testing includes:
  - The endpoint returns merchants equal to the quantity query params
  - The endpoint returns all merchants if the quantity query params is larger then the number of merchants
- Edge case testing includes:
  - The endpoint does not includes merchants that do not have any successful transactions
- Sad path testing includes:
  - The endpoint returns a 400 response if the quantity query param is less then 1
  - The endpoint returns a 400 response if the quantity query param is a string
  - The endpoint returns a 400 response if the quantity query param is blank
  - The endpoint returns a 400 response if the quantity query param is not provided

##### Items_by_revenue endpoint
- Happy path testing includes:
  - The endpoint returns 10 items by default, ordered by revenue
  - The endpoint returns items equal to the quantity query params if provided
  - The endpoint returns all items if the quantity query params is larger then the number of merchants
- Edge case testing includes:
  - The endpoint does not includes items that do not have any successful transactions
- Sad path testing includes:
  - The endpoint returns a 400 response if the quantity query param is less then 1
  - The endpoint returns a 400 response if the quantity query param is a string
  - The endpoint returns a 400 response if the quantity query param is blank

##### Unshipped_invoices_by_revenue
- Happy path testing includes:
  - The endpoint returns 10 unshipped invoices ranked by potential revenue as the default
  - The endpoint returns unshipped invoices equal to the quantity query params if provided
  - The endpoint returns all of the unshipped invoices if the quantity query params are greater then the number of unshipped invoices
- Edge case testing includes:
- Sad path testing includes:
  - The endpoint returns a 400 response if the quantity query param is less then 1
  - The endpoint returns a 400 response if the quantity query param is a string
  - The endpoint returns a 400 response if the quantity query param is blank
