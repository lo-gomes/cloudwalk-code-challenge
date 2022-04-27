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
      game_counter += 1 if line.include?("InitGame")
      current_game = "game_#{game_counter}"

      if current_game != WAITING_ROOM and not games.key?(current_game)
        games[current_game] = {
          "total_kills" => 0,
          "players" => [],
          "kills" => {},
          "kills_by_means" => {}
        }
      end

      if line.include?("ClientUserinfoChanged")
        extract_player(line, games[current_game])
      end
    end

    games
  end

  private

  def extract_player(line, game)
    player = line.split("n\\")[1].split("\\t")[0]

    game["players"].append(player) if not game["players"].include?(player)
  end
end
