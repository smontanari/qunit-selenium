require 'selenium-webdriver'
require_relative 'test_run'

module QUnit
  module Selenium
    class TestRunner
      def initialize(driver = nil)
        @driver = driver || ::Selenium::WebDriver.for(:firefox)
      end

      def open(url, options = {})
        timeout = options[:timeout] || 10
        force_refresh = options[:force_refresh] || false
        
        @driver.get url
        @driver.navigate.refresh if force_refresh

        TestRun.new(@driver).tap do |run|
          ::Selenium::WebDriver::Wait.new(timeout: timeout).until do
            run.completed?
          end
        end.result
      end
    end
  end
end