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


https://pagaml.herokuapp.com/


$ heroku login
$ heroku run rake db:seed import:loans import:payments --app pagaml 

$ heroku run bash

#the console
$ heroku run jirb --app pagaml  
$ heroku console --app pagaml  

$ heroku pg:psql --app pagaml

#BACKUP DB pull:push
$ heroku pg:pull pagaml::DATABASE mylocaldb --app pagaml