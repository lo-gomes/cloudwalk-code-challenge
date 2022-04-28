# frozen_string_literal: true

require_relative "./src/reporter.rb"

if ARGV.length < 1
  puts "Too few arguments"
  exit -1
end

Reporter.new(log_file: ARGV[0]).report
