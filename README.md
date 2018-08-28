# Portafolio test App


* Website to test load of images to Rails Active Storage with amazon S3, It is a simple portfolio page where an user image, a title, a text description and a list of 5 tweets of the user timeline.

* Passenger App server deploying test.
## Web Site

It allows to create and manage profiles, it is necessary to login to enter the site.

### Some considerations:
* Profile images are uploaded to Amazon S3
* It is necessary to create the users in the database to use the application, these are in db/seeds.rb
* Execute rake db:seed to fill databse with users

## API

### GET /portfolio_api/user_info
Example for get user info:

```curl
curl -X GET \
  http://localhost:3000/portfolio_api/user_info/:id \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json'
```
* id is the profile id to search

### POST /portfolio_api/modify_user_info

```curl
curl -X POST \
  'http://localhost:3000/portfolio_api/modify_user_info?id=8&name=name&description=prueba&twitter_account=twitterdev' \
  -H 'Cache-Control: no-cache'
```

## Deploy APP

### Prerequisites:

To resize the images is necessary have installed ImageMagick, for installation follow the instructions:

```
* On debian
sudo apt-get install imagemagick

* On Mac
brew install imageMagick
```

Or more instructions [here](https://www.imagemagick.org/script/install-source.php)

### Apache server
* The deploy will be done by Passenger App server.

* Install passenger gem

```
gem install passenger --no-rdoc --no-ri
```

* Install Passenger Apache module
```
gem install passenger --no-rdoc --no-ri
```

* Install required gems

```
bundle install --deployment --without development test
```

* Compile Rails assets and run database migrations
```
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
```

* Determine the Ruby command that Passenger should use

```
passenger-config about ruby-command
passenger-config was invoked through the following Ruby interpreter:
  Command: /usr/local/rvm/gems/ruby-2.2.7/wrappers/ruby
  Version: ruby 2.2.7p470 (2017-03-28 revision 58194) [x86_64-darwin17]

* Edit apache conf

```
<VirtualHost *:80>
    ServerName yourserver.com

    DocumentRoot /var/www/app/portafolio/public

    PassengerRuby /usr/local/rvm/gems/ruby-2.2.7/wrappers/ruby

    # Relax Apache security settings
    <Directory /var/www/app/portafolio/public>
      Allow from all
      Options -MultiViews
      # Uncomment this if you're on Apache >= 2.4:
      #Require all granted
    </Directory>
</VirtualHost>

* Restart apache

```
sudo apachectl restart
```

### Puma server

* Install required gems

```
bundle install --deployment --without development test
```

* Migrate DB

```
rake db:migrate
```

* Fill database

```
rake db:seed
```

* run server

```
rails s
```