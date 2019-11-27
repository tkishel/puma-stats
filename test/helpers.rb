# frozen_string_literal: true

require 'net/http'
require 'puma'
require 'puma/configuration'
require 'puma/events'
require 'puma/plugin/stats'
require 'timeout'

module Helpers
  def response
    @response ||= Net::HTTP.start uri.host, uri.port do |http|
      http.request Net::HTTP::Get.new('/puma-stats')
    end.body
  end

  def uri
    URI.parse(@configuration.options[:stats_url] || 'tcp://127.0.0.1:51209')
  end

  def start_server(configuration)
    @wait, @ready = IO.pipe

    @events = Puma::Events.strings
    @events.on_booted { @ready << '!' }

    @configuration = configuration
    @launcher = Puma::Launcher.new(@configuration, events: @events)

    @launcher_thread = Thread.new do
      Thread.current.abort_on_exception = true
      @launcher.run
    end

    wait_booted
  end

  def stop_server
    @launcher.stop
    @wait.close
    @ready.close
    @launcher_thread.join
  end

  def cluster_booted?
    worker_status = JSON.parse(Puma.stats)['worker_status']

    (worker_status.length == @configuration.options[:workers]) &&
      (worker_status.all? { |w| w.key?('last_status') && w['last_status'].key?('backlog') })
  end

  def wait_booted
    @wait.sysread 1
    return unless @configuration.options[:workers] > 0

    # Wait for workers to report 'last_status'
    Timeout.timeout(15) do
      sleep 0.2 until cluster_booted?
    end
  end
end
