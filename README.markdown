# procol Rails application

The procol Rails application is the portal which uses the [procol webservices](https://github.com/lopez-99procol/procol-webservices).

procol Rails application is configured to run without a database configuration.
If you wanna set up a Rails application without database config follow [these](http://stackoverflow.com/questions/821251/how-to-configure-ruby-on-rails-with-no-database) instructions.

## procol rails application startup
In order to run the rails application you have to set the SINATRA_BASE_URI environment variable upfront.
This variable is used to point to the right SINATRA webservice server (either localhost or openshift).
``
# local
export SINATRA_BASE_URI=http://localhost:9292
foreman start web

# heroku
``
# check if already set
heroku config:get SINATRA_BASE_URI 
heroku config:set SINATRA_BASE_URI=http://sinatrausers-procol.rhcloud.com
``
