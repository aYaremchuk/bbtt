BBTT
====
[![Build Status](https://travis-ci.org/aYaremchuk/bbtt.svg?branch=master)](https://travis-ci.org/aYaremchuk/bbtt)
[![Maintainability](https://api.codeclimate.com/v1/badges/a5995c0e140d65b9f1b3/maintainability)](https://codeclimate.com/github/aYaremchuk/bbtt/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a5995c0e140d65b9f1b3/test_coverage)](https://codeclimate.com/github/aYaremchuk/bbtt/test_coverage)


System to create posts and distribute them


### Basic system specs:
- Ruby 2.5.0
- Rails 5.2.0.rc1

### DB adapter:
- PostgreSQL

### Additional requirement
- Redis

### Configuration
* bundle
* copy config/database.example.yml into config/database.yml
* set your username and password into config/database.yml for postgreSQL
* rake db:create
* rake db:migrate
* rake db:fill_users
* rails s
* sidekiq

### Credentials
- Admin user  
login: admin@test.com
password: 123456789

- User  
login: user@test.com
password: 12345678
