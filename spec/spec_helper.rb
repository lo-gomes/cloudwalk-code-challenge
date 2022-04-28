# frozen_string_literal: true

require "active_support/all"

SAMPLE_LOG = File.join(File.dirname(__FILE__), "stubs", "sample_log.log")
SIMPLE_KILL_LOG = File.join(File.dirname(__FILE__), "stubs", "simple_kill_log.log")
WORLD_KILL_LOG = File.join(File.dirname(__FILE__), "stubs", "world_kill_log.log")
KILLS_BY_MEANS_LOG = File.join(File.dirname(__FILE__), "stubs", "kills_by_means_log.log")

Dir.glob(File.join(File.expand_path("..", __dir__), "src", "*.rb")).each do |file|
  autoload File.basename(file, ".rb").camelize, file
end

RSpec.configure do |config|
  config.order = "random"
end
