# frozen_string_literal: true

SAMPLE_LOG = File.join(File.dirname(__FILE__), "stubs", "sample_log.log")

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
end
