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
This gem is a wrapper around the [selenium-webdriver](http://rubygems.org/gems/selenium-webdriver) gem with the additional logic to parse the QUnit test results page and report the success/failure of your QUnit tests.
Please refer to the selenium documentation for detail instructions and drivers/browsers support.

*_By default qunit-selenium will use the Selenium *FirefoxDriver* instantiated with a new Firefox profile._*

If you wish to use a different driver, or to customise your driver behaviour you can still use qunit-selenium through its API (see below.)

## Usage

### Command line

    $ qunit-selenium [--timeout=seconds] [--screenshot=FILE] URL

This command will open the QUnit test page at the given url and wait for the  tests to complete before collecting and displaying the test run results. If the tests do not complete within the given timeout (by default it's 10 seconds) Selenium will raise an error and the command will fail.

More in general, if any error is raised by Selenium which would cause a premature end of the test run, the program will generate a screenshot of the error page (file `qunit-selenium-error.png`).

Example:

    $ qunit-selenium --timeout 20 --screenshot mytests.png http://myserver/tests

### Ruby API

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

