# frozen_string_literal: true

require "active_support/all"

Dir.glob(File.join(File.expand_path("..", __dir__), "src", "*.rb")).each do |file|
  autoload File.basename(file, ".rb").camelize, file
end

RSpec.configure do |config|
  config.order = "random"
end
