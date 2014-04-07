require 'spec_helper'

require 'rack/test'

require 'rack-slow-log'

describe Rack::SlowLog do
  include Rack::Test::Methods

  let(:application_class) {
    Class.new do
      def initialize(sleep_time)
        @sleep_time = sleep_time
      end

      def call(env)
        sleep(@sleep_time)

        env['rack.slow_log'].log('First log line.')
        env['rack.slow_log'] << ('Second log line.')

        [200, {}, 'success']
      end
    end
  }

  let(:long_request_time) { 0.5 }
  let(:log_path) { '/tmp/log' }

  let(:options) { { :long_request_time => long_request_time, :slow_log => "#{log_path}/slow.log" } }

  def app
    Rack::SlowLog.new(application_class.new(sleep_time), options)
  end

  before do
    FileUtils.mkdir_p(log_path)
    FileUtils.rm_rf(Dir.glob("#{log_path}/*"))
  end

  describe '#call' do

    context  'when the request takes less than required' do
      let(:sleep_time) { long_request_time - 0.2 }

      it 'does not generate the slow log' do
        get '/'

        File.exists?("#{log_path}/slow.log").should be_false
      end
    end

    context  'when the request takes more than required' do
      let(:sleep_time) { long_request_time + 0.2 }

      it 'generates the slow log' do
        get '/'

        File.exists?("#{log_path}/slow.log").should be_true
      end

      context 'when one_log_per_request is true' do

        before { options[:one_log_per_request] = true }

        it 'generates one log file per slow request' do
          get '/'
          get '/'

          Dir["#{log_path}/*"].should have(2).elements
        end
      end
    end

  end

end