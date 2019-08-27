# Octo Events

A REST API for registering issue events triggered by Github webhooks.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

*  PostgreSQL
*  Bundler

### Installing

Install gem dependencies by running:

```
bundle
```

Configure your database credentials on the .env file:

```
# .env

DB_USERNAME=username
DB_PASSWOR=password
```

Setup your database:

```
rake db:setup
```

Start the application with foreman:

```
foreman start -f Procfile.dev
```

You should see something like this:

```
20:06:13 web.1  | started with pid 9214
20:06:14 web.1  | Puma starting in single mode...
20:06:14 web.1  | * Version 3.12.1 (ruby 2.6.3-p62), codename: Llamas in Pajamas
20:06:14 web.1  | * Min threads: 5, max threads: 5
20:06:14 web.1  | * Environment: development
20:06:14 web.1  | * Listening on tcp://0.0.0.0:5000
20:06:14 web.1  | Use Ctrl-C to stop
```

Voilá!

## Running the tests

To run the tests use:

```
bundle exec rspec
```

## Live testing

A live demo of the application is available at: https://diguliu-octo.herokuapp.com/

You can live test it using a api testing tool like [Postman](https://www.getpostman.com/) or by managing issues on http://github.com/diguliu/jaya-test/.

Here are the available endpoints:
*  **GET** /issues/:issue\_id/events: retrieves every event of an issue
*  **POST** /events (issue\_id:string, action:string): register an event on an issue

## Authentication

Autentication is needed in the application in order to use the event creation endpoint. There are 2 different methods of authentication:
1. Secret token
2. Login

### Secret Token

To authenticate via secret token you need to generate one and define it on the `.env` file. You can generate a secure token like this:
```
ruby -rsecurerandom -e 'puts SecureRandom.hex(20)'
```

Then place it on the `.env` file.

```
# .env

SECRET_TOKEN=674324f85ed23105a95a095d0739716feb543968
```

Finally you just need to configure this token on the Gihub Webhook.

### Login

To authenticate via login you need to define a login and a password and store them on them `.env` file.
```
LOGIN=jack
PASSWORD=abc
```

Now you can post create request passing `login` and `password` to authentica.

## Deployment

The only deployment available right now is via Gitlab CI/CD to a Heroku app using dpl. Look for further documentation at: https://github.com/travis-ci/dpl

## Built With

* [Rails](https://rubyonrails.org//) - The web framework used
* [Bundler](https://bundler.io/) - Dependency Management

## Authors

* **Rodrigo Souto** - [Gitlab](https://gitlab.com/diguliu)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
