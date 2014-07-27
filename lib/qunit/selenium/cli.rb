require 'thor'
require 'selenium-webdriver'
require_relative 'test_runner'

module QUnit
  module Selenium
    class Cli < Thor
      desc "open URL", %{Run qunit tests at the specified URL}
      option :timeout, type: :numeric, default: 10, desc: "Timeout in seconds to wait for the tests to complete (default is 10)"
      option :screenshot, banner: 'FILE', default: nil, desc: "Save a screenshot of the page to the specified FILE after the tests complete"

      def open(url)
        profile = ::Selenium::WebDriver::Firefox::Profile.new
        driver = ::Selenium::WebDriver.for :firefox, profile: profile

        begin
          test_result = TestRunner.new(driver).open(url, timeout: options[:timeout])
          driver.save_screenshot options[:screenshot] if options[:screenshot]

          print_report(test_result)

          error = test_result.assertions[:failed] > 0
        rescue => e
          puts "Error: #{e}"
          driver.save_screenshot('qunit-selenium-error.png')
          error = true
        ensure
          driver.quit
        end
        exit(1) if error
      end

      default_task :open

      private

      def print_report(result)
        puts "Total tests: #{result.tests[:total]}"
        puts "Passed:      #{result.tests[:passed]}"
        puts "Failed:      #{result.tests[:failed]}"
        puts "Total assertions: #{result.assertions[:total]}"
        puts "Passed:           #{result.assertions[:passed]}"
        puts "Failed:           #{result.assertions[:failed]}"
        puts "Tests duration:   #{result.duration} seconds"
      end
    end
  end
end