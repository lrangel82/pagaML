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
$ heroku run rake db:migrate --app pagaml 

$ heroku run bash

#the console
$ heroku run jirb --app pagaml  
$ heroku console --app pagaml  

$ heroku pg:psql --app pagaml

#BACKUP DB pull:push
$ heroku pg:pull pagaml::DATABASE mylocaldb --app pagaml
```sh
#Create
heroku pg:backups:capture --app pagaml

#Download
heroku pg:backups:url b001 --app pagaml

#Restore
heroku pg:backups:restore b001 DATABASE_URL --app pagaml



#Sownload a backup
heroku pg:backups:capture --app pagaml
heroku pg:backups:download --app pagaml
#pg_restore --verbose --clean --no-acl --no-owner -h localhost -U myuser -d mydb latest.dump
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U larangel -d pagaml_development latest.dump
```