# TimeDoctor

[![Build Status](https://travis-ci.org/roonyx/timedoctor.svg?branch=master)](https://travis-ci.org/roonyx/timedoctor)
[![codecov](https://codecov.io/gh/roonyx/timedoctor/branch/master/graph/badge.svg)](https://codecov.io/gh/roonyx/timedoctor)
[![Maintainability](https://api.codeclimate.com/v1/badges/c960738630bd0a4aa9d2/maintainability)](https://codeclimate.com/github/roonyx/timedoctor/maintainability)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'timedoctor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install timedoctor

## Usage
To get started first you need to register your application and acquire Client ID.
Next, you need to build URI for your application to request permission to access user account.

`https://webapi.timedoctor.com/oauth/v2/auth?client_id=<YOUR_CLIENT_ID>&response_type=code&state=<STATE>&redirect_uri=<CALLBACK_URI>`

Here's breakdown of url parameters:
`YOUR_CLIENT_ID` - Client ID for your application.
`STATE` - random string to validate authentication integrity in callback.
`CALLBACK_URI` - URI to your application endpoint which will be used upon successful authentication.

> Make sure that `CALLBACK_URI` matches URI that you used during registration of Timedoctor application.

When url is visited and permission to access user account is successfuly granted, user will be redirected to `CALLBACK_URI` that you provided earlier with `code` and `state` as parameters.

Optionally, you can validate `state` value to make sure that it's same as generated previously for this user.

### Generating access token
To generate access token to work with API you will need to use `code` that you received as parameter to your callback endpoint:
```ruby
token = TimeDoctor::Auth.new(
  code: params[:code],
  redirect_uri: 'https://your_app_host/callback'
).fetch_token
```
After that, you can create client to work directly with Timedoctor API:
```ruby
client = TimeDoctor::Client.new(
  access_token: token[:access_token],
  refresh_token: token[:refresh_token]
)
```
> Make sure to store `access_token` and `refresh_token` somewhere safe for that user, so you can use it later.

### Requesting account information
To get account information such as name and company details you can use following command:
```ruby
account = client.companies.list
puts "Account owner name: #{account[:user][:full_name]}"
puts "Account email: #{account[:user][:email]}"
puts "User ID: #{account[:user][:user_id]}"
puts "Company ID: #{account[:user][:company_id]}"
```

### Requesting worklogs
To request worklogs you will need to provide `company_id`, `start_date` and `end_date`. `user_ids` can also be used to narrow down returned data. Here's how to get worklogs for user associated with access token for today:
```ruby
account = client.companies.list
client.worklogs.list(
  company_id: account[:user][:company_id],
  user_ids: account[:user][:user_id],
  start_date: Date.today,
  end_date: Date.today
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/roonyx/timedoctor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TimeDoctor project’s codebases, issue trackers, chat rooms and mailing lists.
