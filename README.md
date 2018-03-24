BBTT
====
system to create posts and distribute them


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

### Credentials
- Admin user  
login: admin@test.com
password: 123456789

- User  
login: user@test.com
password: 12345678
