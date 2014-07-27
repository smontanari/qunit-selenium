qunit-selenium
==============

Ruby QUnit test runner for Selenium WebDriver

## Install

In your Gemfile:

```ruby
gem 'qunit-selenium'
```

Or in your ruby gems:

    $ gem install qunit-selenium

## Pre-requisites
This gem is a wrapper around the [selenium-webdriver](http://rubygems.org/gems/selenium-webdriver) gem.
Please refer to its documentation for detail instructions and drivers/browsers support.

_By default qunit-selenium will use a *FirefoxDriver* instantiated with a new profile._

## Usage

### Command line

    $ qunit-selenium [--timeout=seconds] [--screenshot=FILE] URL

This command will open the given url and wait for the QUnit tests to complete before collecting and displaying the test run results.

Example:

    $ qunit-selenium --timeout 20 --screenshot mytests.png

### Through the API

```ruby
require 'qunit/selenium/test_runner'

driver = ::Selenium::WebDriver.for :firefox
url = 'http://test.server.com:8080'

result = QUnit::Selenium::TestRunner.new(driver).open(url, timeout: 30)

puts "Total tests: #{result.tests[:total]}"
puts "Passed:      #{result.tests[:passed]}"
puts "Failed:      #{result.tests[:failed]}"

driver.quit
```

