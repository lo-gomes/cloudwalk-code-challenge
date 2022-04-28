# frozen_string_literal: true

require "json"

require_relative "./parser.rb"

class Reporter
  def initialize(log_file:)
    @log_file = log_file
  end

  def report
    result = Parser.new(log_file: @log_file).parse

    result.each do |game, data|
      puts "\nGame: #{game}\n\n"
      puts JSON.pretty_generate(data)
      puts print_rank(data)
      puts "-------------------------"
    end
  end

  private

  def print_rank(data)
    return nil if data["kills"].empty?

    ranking = data["kills"].sort_by { |_, value| value }.reverse.to_h

    puts "\nRanking:\n\n"

    ranking.each do |player, score|
      puts "#{player}: #{score}"
    end

    nil
  end
end
