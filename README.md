# RESTful API for SOF

## Useful Rail commands:

To run the server:
```
$rails server
```
or
```
$rails s
```

To start a console for the database:
```
$rails dbconsole
```

To see all the possible calls for the RESTful API:
```
$rails routes
```

## Deployment
Requires PostgreSQL and ruby

To install bundler
```
$gem install bundler
```

To install ruby on rails:
```
$gem install rails
```

Run the setup file for the project
```
$ruby /bin/setup
```

This will install all dependencies from the gemfile and setup database.
(can also be done with ```$bundle install``` to install dependencies and ```ruby bin/rails db:setup``` to setup database)

After this you _might_ have to update which versions you're using in the gemfile.

Then you should be good to go, enjoy!

## External libraries used

For [authentification](https://github.com/lynndylanhurley/devise_token_auth) (login, registration, etc.):

To get local smtp server up and running for local development use [mailcatcher](https://mailcatcher.me/).
```$gem install mailcatcher``` and then ```$mailcatcher``` will start the smtp server at http://localhost:1025. You can see all e-mails sent at http://localhost:1080.
**Do not include mailcatcher in your gemfile**

## File structure
If you're looking at a ruby on rails project for the first time this might be a
little confusing. [Here's](https://www.javatpoint.com/ruby-on-rails-directory-structure) a short intro.
For more extensive info; Google is your friend.

## Docker (devstack)
To build the backend container and setup the Docker environment, run
```
docker-compose -f devstack.yml build
```
You might need to do it if you make certain changes to the code, 
not sure which, but rule of thumb is if you change a config, rebuild.

And if it's already built and you just wanna start the environment, run
```
docker-compose -f devstack.yml up
```

And because the person who made the compose-file is lazy, the database
is wiped on restart of the service

And to get to the database you can do
```
docker-compose -f devstack.yml exec db su postgres -c psql
```

Included in the devstack is a Mailcatcher on ```localhost:1080```

