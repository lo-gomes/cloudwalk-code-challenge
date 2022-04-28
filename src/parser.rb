# frozen_string_literal: true

class Parser
  WAITING_ROOM = "game_0"
  WORLD_PLAYER = "<world>"

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

      extract_player(line, games[current_game]) if line.include?("ClientUserinfoChanged")
      extract_kill(line, games[current_game]) if line.include?("Kill:")
    end

    games
  end

  private

  def extract_player(line, game)
    player = line.split("n\\")[1].split("\\t")[0]

    game["players"].append(player) if not game["players"].include?(player)
  end

  def extract_kill(line, game)
    players = line.split("by")[0].split(":").reverse[0].split("killed").map { |player| player.strip }

    if players[0] == WORLD_PLAYER
      game["kills"][players[1]] = 0 if not game["kills"].include?(players[1])
      game["kills"][players[1]] -= 1
    else
      game["kills"][players[0]] = 0 if not game["kills"].include?(players[0])
      game["kills"][players[0]] += 1
    end

    game["total_kills"] += 1
  end
end
