# Rails Engine API

###### Auther: [Doug Welchons](https://github.com/DougWelchons)


Rails engine is designed to simulate the backend portion of a internet sales platform,
providing to the front end program (not a part of this project), API endpoints to relevant data in the database.


This project was built with:
* Ruby version 2.5.3<br>
* Rails version 5.2.5

This project was tested with:
* RSpec version 3.10

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
    - [All items](#all-items-endpoints)
    - [All merchants](#all-merchants-endpoints)
    - [Find item](find-item-endpoint)
    - [Find merchants](find-merchants-endpoint)
    - [Merchants by revenue](merchants-by-revenue-endpoint)
    - [Merchants by items sold](merchants-by-items-sold-endpoint)
    - [Items by revenue](items-by-revenue-endpoint)
    - [Unshipped invoices by revenue](unshipped-invoices-by-revenue)



### Endpoint Documentation
###### All items
- This endpoint returns a list of items
  - optional query params:
    - page=<integer> (must be 1 or greater) default = 1
    - per_page=<integer> (must be 1 or greater) default = 20
  - examples:
    - http://localhost:3000/api/v1/items (returns items 1 - 20 by default)
    - http://localhost:3000/api/v1/items?page=2&per_page=50 (returns items 51 - 100)

###### All merchants
- This endpoint returns a list of merchants
  - optional query params:
    - page=<integer> (must be 1 or greater) default = 1
    - per_page=<integer> (must be 1 or greater) default = 20
  - examples:
    - http://localhost:3000/api/v1/merchants (returns merchants 1 - 20 by default)
    - http://localhost:3000/api/v1/merchants?page=2&per_page=50 (returns merchants 51 - 100)

###### Find item
- This endpoint returns the first item (sorted alphabetically) that matches the search params.
  - At least on of the following params must be included. Additionally you cannot search by price and name.
    - name=<string>
    - min_price=<float or integer> (must be 0 or greater)
    - max_price=<float or integer> (must be 0 or greater)
  - examples:
    - http://localhost:3000/api/v1/items/find?name=Merchant (returns a single valid result)
    - http://localhost:3000/api/v1/items/find?min_price=25 (returns a single valid result)
    - http://localhost:3000/api/v1/items/find?max_price=25 (returns a single valid result)
    - http://localhost:3000/api/v1/items/find?min_price=25&max_price=30 (returns a single valid result)

###### Find merchants
- This endpoint returns all of the merchants (sorted alphabetically) that match the search params.
  - Required params:
    - name=<string>
  - examples:
    - http://localhost:3000/api/v1/merchants/find_all?name=merchant (returns all valid results)

###### Merchants by revenue
- This endpoint returns a list of merchants, sorted by total revenue
  - required params:
    - quantity=<intiger> (must be 1 or greater)
  - examples:
    - http://localhost:3000/api/v1/revenue/merchants?quantity=10 (returns first 10 results)

###### Merchants by items sold
- This endpoint returns a list of merchants, sorted by total items sold
  - required params:
    - quantity=<intiger> (must be 1 or greater)
  - examples:
    - http://localhost:3000/api/v1/merchants/most_items?quantity=8 (returns first 8 results)

###### Items by revenue
- This endpoint returns a list of items, sorted by total items sold
  - Optional params:
    - quantity=<intiger> (must be 1 or greater)
  - examples:
    - http://localhost:3000/api/v1/revenue/items (returns first 10 results by default)
    - http://localhost:3000/api/v1/revenue/items?quantity=8 (returns first 8 results)

###### Unshipped invoices by potential revenue
- This endpoint returns a list of invoices that have not been shipped, sorted by total potential revenue
  - Optional params:
    - quantity=<intiger> (must be 1 or greater)
  - examples:
    - http://localhost:3000/api/v1/revenue/unshipped (returns first 10 results by default)
    - http://localhost:3000/api/v1/revenue/unshipped?quantity=8 (returns first 8 results)



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
- Sad path testing includes:
  - The endpoint returns a 400 response if both a name and price query param are give
  - The endpoint returns a 400 response if the min or max price query params are less then 0
  - The endpoint returns a 400 response if the maximum value is less then the minimum value

##### Find_merchants (search) endpoint
- Happy path testing includes:
  - The endpoint returns all merchants who match the name search params
  - The endpoint returns no objects if no merchants match the name search params
- Edge case testing includes:
- Sad path testing includes:
  - The endpoint returns a 400 response if the name search params is not provided
  - The endpoint returns a 400 response if the name search params is blank

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
