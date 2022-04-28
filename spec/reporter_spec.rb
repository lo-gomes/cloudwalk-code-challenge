# frozen_string_literal: true

describe Reporter do
  describe "#report" do
    it "should correctly print out raking for each game" do
      reporter = Reporter.new(log_file: SIMPLE_KILL_LOG)

      expected_output = [
        {
          header: "Game: game_1",
          ranking: nil
        },
        {
          header: "Game: game_2",
          ranking: "\nRanking:\n\nDono da Bola: 1\nIsgalamido: 1"
        },
      ]

      expected_output.each do |expected|
        expect { reporter.report }.to output(/#{expected[:header]}/).to_stdout
        expect { reporter.report }.to output(/#{expected[:ranking]}/).to_stdout
      end
    end
  end
end
