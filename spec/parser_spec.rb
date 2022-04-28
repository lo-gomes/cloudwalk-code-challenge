# frozen_string_literal: true

describe Parser do
  describe "#parse" do
    it "should raise an error when log file is not found" do
      expect{Parser.new(log_file: "invalid").parse}.to raise_error(Errno::ENOENT)
    end

    it "should collect matches correctly" do
      expected_result = ["game_1", "game_2", "game_3", "game_4", "game_5"]
      result = Parser.new(log_file: SAMPLE_LOG).parse

      expect(result.keys).to eq(expected_result)
    end
  end

  it "should collect players for each match" do
    expected_result = {
      "game_1" => { "players" => ["Isgalamido"] },
      "game_2" => { "players" => ["Isgalamido", "Dono da Bola", "Mocinha"] },
      "game_3" => { "players" => ["Dono da Bola", "Mocinha", "Isgalamido", "Zeh"] },
      "game_4" => { "players" => ["Dono da Bola", "Isgalamido", "Zeh", "Assasinu Credi"] },
      "game_5" => { "players" => ["Isgalamido", "Oootsimo", "Dono da Bola", "Assasinu Credi", "Zeh", "Mal"] }
    }

    result = Parser.new(log_file: SAMPLE_LOG).parse

    expected_result.each do |key, value|
      expect(result[key]["players"]).to eq(expected_result[key]["players"])
    end
  end

  it "should collect kill data by players for each match" do
    expected_result = {
      "game_2" => {
        "kills" => {
          "Isgalamido" => 1,
          "Dono da Bola" => 1
        }
      }
    }

    result = Parser.new(log_file: SIMPLE_KILL_LOG).parse

    expected_result.each do |key, value|
      expect(result[key]["kills"]).to eq(expected_result[key]["kills"])
    end
  end

  it "should correctly handle <world> kills" do
    expected_result = {
      "game_2" => {
        "kills" => {
          "Isgalamido" => -2,
          "Dono da Bola" => 1
        }
      }
    }

    result = Parser.new(log_file: WORLD_KILL_LOG).parse

    expected_result.each do |key, value|
      expect(result[key]["kills"]).to eq(expected_result[key]["kills"])
    end
  end

  it "should correctly count total kills" do
    result = Parser.new(log_file: WORLD_KILL_LOG).parse
    expect(result["game_2"]["total_kills"]).to eq(5)
  end

  it "should correctly count kills by means" do
    expected_result = {
      "game_2" => {
        "kills_by_means" => {
          "MOD_SHOTGUN" => 10,
          "MOD_RAILGUN" => 2,
          "MOD_ROCKET_SPLASH" => 3
        }
      }
    }

    result = Parser.new(log_file: KILLS_BY_MEANS_LOG).parse
    expect(result["game_2"]["kills_by_means"]).to eq(expected_result["game_2"]["kills_by_means"])
  end
end
