require_relative 'slow_log/logger'

module Rack
  class SlowLog

    def initialize(app, options = {})
      @app = app
      @long_request_time = options.fetch(:long_request_time, 5)
      @slow_log = options.fetch(:slow_log, 'log/slow.log')
      @one_log_per_request = options.fetch(:one_log_per_request, false)
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      logger = Logger.new(@long_request_time, @slow_log, @one_log_per_request)

      logger.request_start!
      env['rack.slow_log'] = logger
      app_response = @app.call(env)
      logger.request_end!

      logger.save

      app_response
    end

  end
end