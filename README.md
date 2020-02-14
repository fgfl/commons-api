# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# SETUP

- install `yarn`
- run `bundle install`

### Postgres Setup

External guide:
https://www.daveferrara1.com/ruby-in-rails-switch-from-sqlite3-to-postgres/

- create a development user
  - create a copy of the `config/secrets.yml.example` and rename it to `config/secrets.yml`.
  - change the username and password to your development user and password
- log in to the postgres with the dev user and create the dev and test database

```sql
CREATE DATABASE commons_development;
CREATE DATABASE commons_test;
```
