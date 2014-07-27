require 'qunit/selenium/test_runner'

module QUnit
  module Selenium
    describe TestRunner do
      shared_examples 'open test page' do |timeout|
        let(:test_run) {double('test_run')}
        let(:wait) {double('wait')}

        before do
          allow(TestRun).to receive(:new).with(driver).and_return(test_run)
          allow(::Selenium::WebDriver::Wait).to receive(:new).with(timeout: timeout).and_return(wait)
          allow(wait).to receive(:until).and_yield
          expect(test_run).to receive(:completed?).ordered
          allow(test_run).to receive(:result).ordered.and_return('result')
        end

        it 'returns the completed test run' do
          expect(subject).to eq('result')
        end
      end
      
      let(:driver) {double('driver')}

      before do
        expect(driver).to receive(:get).with('test_url').ordered
      end

      describe ' #open' do
        context 'default options' do
          let(:subject) {TestRunner.new(driver).open('test_url')}

          include_examples 'open test page', 10
        end

        context 'custom options' do
          let(:subject) {TestRunner.new(driver).open('test_url', timeout: 30)}

          include_examples 'open test page', 30
        end
      end
    end
  end
end