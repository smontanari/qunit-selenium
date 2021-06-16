module QUnit
  module Selenium
    class TestRun
      TestResult = Struct.new(:tests, :assertions, :duration, :raw_output)
      ID_TESTRESULT = 'qunit-testresult'
      ID_TESTS = 'qunit-tests'

      def initialize(driver)
        @qunit_testresult = driver[ID_TESTRESULT]
        @qunit_tests = driver[ID_TESTS]
      end

      def completed?
        @qunit_testresult.text =~ /Tests completed/
      end

      def result
        assertions = {total: total_assertions, passed: passed_assertions, failed: failed_assertions}
        tests = {total: total_tests, passed: pass_tests, failed: fail_tests}
        TestResult.new(tests, assertions, duration, raw_output)
      end

      private

      def raw_output
        @qunit_tests.text
      end

      def duration
        match = /Tests completed in (?<milliseconds>\d+) milliseconds/.match @qunit_testresult.text
        match[:milliseconds].to_i / 1000
      end

      %w(total passed failed).each do |result|
        define_method("#{result}_assertions".to_sym) do
          @qunit_testresult.find_elements(:class, result).first.text.to_i
        end
      end

      def total_tests
        @qunit_tests.find_elements(:css, "##{ID_TESTS} > *").count
      end

      %w(pass fail).each do |result|
        define_method("#{result}_tests".to_sym) do
          @qunit_tests.find_elements(:css, "##{ID_TESTS} > .#{result}").count
        end
      end
    end
  end
end
