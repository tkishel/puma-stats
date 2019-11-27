# frozen_string_literal: true

require 'helpers'
require 'minitest/autorun'
require 'puma/configuration'

class TestConfig < Minitest::Test
  include Helpers

  def test_default_stats_url
    configuration = Puma::Configuration.new do |config|
      config.bind 'tcp://127.0.0.1:0'
      config.plugin 'stats'
      config.quiet
      config.app { [200, {}, ['Hello World']] }
    end

    start_server(configuration)
    assert_includes response, 'pool_capacity'
    stop_server
  end

  def test_plugin_disabled
    configuration = Puma::Configuration.new do |config|
      config.bind 'tcp://127.0.0.1:0'
      config.quiet
      config.app { [200, {}, ['Hello World']] }
    end

    start_server(configuration)
    assert_raises(Errno::ECONNREFUSED) { response }
    stop_server
  end
end
