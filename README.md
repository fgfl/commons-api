# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# Ruby version

- Ruby: 2.7.0
- Rails: 6.0.2.1

# SETUP

- install `yarn`
- run `bundle install`

### Postgres Setup

External guide:
https://www.daveferrara1.com/ruby-in-rails-switch-from-sqlite3-to-postgres/

- create a development user
  - create a copy of the `config/secrets.yml.example` and rename it to `config/secrets.yml`.
  - change the username and password to your development user and password
  - add your uclassify read and write keys
- log in to the postgres with the dev user and create the dev and test database

```sql
CREATE DATABASE commons_development;
CREATE DATABASE commons_test;
```

### Database Reset

During development it may be necessary to reset the database. If so, do the following actions:

```
rake db: drop
# drops database

in PSQL:
CREATE database commons_development;
CREATE database commons_test;
# creates database again

rake db:reset
# seeds database with categories and session

rake db:update_database

# populates database with bills from legisINFO (takes about a minute and a half)
# if you see Rescue exceptions in the console it means it's working as it should
```

# Heroku Hosting

The API server is hosted on Heroku at https://commons-app-api.herokuapp.com/

It uses the following add-ons:
0

### rspec Testing Setup

To setup rspec testing environment, run

```
rake db:test:prepare
rake db:test:load
```
