# Responsechecker

Given a URL, checks it for the following header (options)

* X-Frame-Options => [DENY, SAMEORIGIN]
* HttpOnly cookies
* Secure cookies
* X-Content-Type-Options => nosniff
* Strict-Transport-Security
* X-XSS-Protection

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'responsechecker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install responsechecker

## Usage

```bash
$ check-response https://people-finder.dsd.io/sessions/new
[✓] X-Content-Type-Options
[✓] X-Frame-Options
[✓] HttpOnly cookie
[✗] Secure cookie
[✗] Strict transport security
[✓] X-XSS-Protection
```
