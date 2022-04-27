# frozen_string_literal: true

class Parser
  WAITING_ROOM = "game_0"

  def initialize(log_file:)
    @log_file = log_file
  end

  def parse
    games = {}
    game_counter = 0

    File.foreach(@log_file) do |line|
      game_counter += 1 if line.include? "InitGame"
      current_game = "game_#{game_counter}"

      if current_game != WAITING_ROOM and not games.key?(current_game)
        games[current_game] = {
          "total_kills" => nil,
          "players" => [],
          "kills" => {},
          "kills_by_means" => {}
        }
      end
    end

    games
  end
end
