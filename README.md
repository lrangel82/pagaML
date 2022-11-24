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


#Run the local postgres server
```bash
pg_ctl -D ~/psql/data start

```
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
#Connection sctring
heroku pg:credentials:url DATABASE --app pagaml
------
Connection info string:
   "dbname=dce6gi1gtmibhc host=ec2-52-44-21-74.compute-1.amazonaws.com port=5432 user=udrkamgynqlhjh password=24c55e6fb725b8e11574d7908cc9614a4acc1af896bfbedc25c4406654ed6cb9 sslmode=require"
Connection URL:
   postgres://udrkamgynqlhjh:24c55e6fb725b8e11574d7908cc9614a4acc1af896bfbedc25c4406654ed6cb9@ec2-52-44-21-74.compute-1.amazonaws.com:5432/dce6gi1gtmibhc
-------
#Create
heroku pg:backups:capture --app pagaml

#Download
heroku pg:backups:url b001 --app pagaml
#or
heroku pg:backups:download --app pagaml

#Restore
heroku pg:backups:restore 'latest.dump' DATABASE_URL --app pagaml



#Sownload a backup
heroku pg:backups:capture --app pagaml
heroku pg:backups:download --app pagaml
#pg_restore --verbose --clean --no-acl --no-owner -h localhost -U myuser -d mydb latest.dump
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U larangel -d pagaml_development latest.dump
```


# GoogleCloud
## Instalar gcloud CLI
https://cloud.google.com/sdk/docs/install-sdk

clone the repo, enter to the source code directory and run
```sh
cd pagaml
gcloud init
#follow the instrucction
# an example
# https://cloud.google.com/appengine/docs/standard/ruby/create-app?hl=en_US

#install gems
bundle install

# Install Node with NPM
brew install node
# Install JavaScript packages
npm install

#run the server
bundle exec rails server
```
