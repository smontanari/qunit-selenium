require 'qunit/selenium/test_run'

module QUnit
  module Selenium
    describe TestRun do
      let(:driver) {double('driver')}
      let(:result_element) {double('result_element')}
      let(:tests_element) {double('tests_element')}

      before do
        allow(driver).to receive(:[]).with('qunit-testresult').and_return(result_element)
        allow(driver).to receive(:[]).with('qunit-tests').and_return(tests_element)
      end

      context 'tests completed' do
        before do
          allow(result_element).to receive(:text).and_return('Tests completed in 3000 milliseconds')
          allow(result_element).to receive(:find_elements).with(:class, 'total').and_return([Struct.new(:text).new('123')])
          allow(result_element).to receive(:find_elements).with(:class, 'passed').and_return([Struct.new(:text).new('456')])
          allow(result_element).to receive(:find_elements).with(:class, 'failed').and_return([Struct.new(:text).new('789')])
          allow(tests_element).to receive(:find_elements).with(:css, '#qunit-tests > *').and_return([1, 2, 3])
          allow(tests_element).to receive(:find_elements).with(:css, '#qunit-tests > .pass').and_return([1, 2])
          allow(tests_element).to receive(:find_elements).with(:css, '#qunit-tests > .fail').and_return([1])
        end

        it 'is completed' do
          expect(TestRun.new(driver).completed?).to be_truthy
        end

        it 'returns the tests result data' do
          result = TestRun.new(driver).result

          expect(result.tests[:total]).to eq(3)
          expect(result.tests[:passed]).to eq(2)
          expect(result.tests[:failed]).to eq(1)
          expect(result.assertions[:total]).to eq(123)
          expect(result.assertions[:passed]).to eq(456)
          expect(result.assertions[:failed]).to eq(789)
        end
      end

      context 'tests running' do
        before do
          allow(result_element).to receive(:text).and_return('Running...')
        end

        it 'is not completed' do
          expect(TestRun.new(driver).completed?).to be_falsy
        end
      end
    end
  end
end