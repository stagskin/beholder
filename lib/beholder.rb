require 'uri'
require 'yaml'
require 'fileutils'
require 'open-uri'

# Gems.
require 'bundler/setup'

Bundler.require(:default)

# Methods that should be accessible everywhere.
module Kernel
  # Runs a block with warning messages supressed.
  def run_supressed(&block)
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    yield block
    $VERBOSE = original_verbosity
  end

  # Converts seconds to human readable format.
  def time_in_words(time)
    days = (time / 86_400).to_i
    time -= days * 86_400
    hours = (time / 3600).to_i
    time -= hours * 3600
    minutes = (time / 60).to_i
    string = "#{days} day#{'s' unless days == 1},"
    string << " #{hours} hour#{'s' unless hours == 1},"
    string << " #{minutes} minute#{'s' unless minutes == 1}"
  end

  # Converts boolean values to more appealing format.
  # Possible modes: on, enabled.
  def bool_to_words(bool, mode = :on)
    case mode
    when :on
      string_if_true = 'on'
      string_if_false = 'off'
    when :enabled
      string_if_true = 'enabled'
      string_if_false = 'disabled'
    else
      raise ArgumentError
    end

    return string_if_true if bool
    string_if_false
  end

  # Returns true if specified url string is valid.
  def valid_url?(url)
    uri = URI.parse(url)
    return true if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    false
  rescue
    false
  end

  # Returns urls host.
  def url_host(url)
    URI.parse(url).host
  rescue
    nil
  end

  # Generates a random string with default length of 10.
  def rand_string(length = 10)
    rand(36**length).to_s(36)
  end
end

# Base module for sapphire.
module Beholder
  run_supressed { Discordrb::LOG_TIMESTAMP_FORMAT = '%Y-%m-%d %H:%M:%S' }

  debug = ARGV.include?('-debug') ? :debug : false
  log_streams = [STDOUT]

  if debug
    timestamp = Time.now.strftime(Discordrb::LOG_TIMESTAMP_FORMAT).tr(':', '-')
    log_file = File.new("#{Dir.pwd}/logs/#{timestamp}.log", 'a+')
    log_streams.push(log_file)
  end

  run_supressed { LOGGER = Discordrb::LOGGER = Discordrb::Logger.new(nil, log_streams) }

  LOGGER.debug = true if debug

  require_relative 'beholder/other/store_data'
  require_relative 'beholder/config'

  CONFIG = Config.new

  Dir["#{File.dirname(__FILE__)}/beholder/*.rb"].each { |file| require file }

  require_relative 'discordrb/server'

  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token,
                                            application_id: CONFIG.discord_client_id,
                                            prefix: CONFIG.prefix,
                                            advanced_functionality: false,
                                            fancy_log: true)
  STATS = Stats.new

  # See lib/commands.rb and lib/events.rb.
  Commands.include!
  Events.include!

  at_exit do
    STATS.save
    ServerConfig.save
    exit!
  end

  LOGGER.info 'Use ctrl+c to safely stop the bot.'
  BOT.run

  loop do
    STATS.update
    ServerConfig.save
    STATS.save
    sleep(10)
  end
end
