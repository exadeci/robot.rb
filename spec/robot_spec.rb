require "spec_helper"

RSpec.describe Robot do

  context "placing the robot" do
    let(:robot) { Robot.new }

    it "is correctly placed" do
      robot.send(:place, "4,2,NORTH")
      expect(STDOUT).to receive(:puts).with("4,2,NORTH")
      robot.send(:report)
    end

    it "shouldn't be placed" do
      expect(STDOUT).to receive(:puts).with("Invalid movement")
      robot.send(:place, "6,-1,NORTH")
    end

    it "turned left to EAST" do
      robot.send(:left)
      expect(STDOUT).to receive(:puts).with("0,0,EAST")
      robot.send(:report)
    end

    it "turned right to WEST" do
      robot.send(:right)
      expect(STDOUT).to receive(:puts).with("0,0,WEST")
      robot.send(:report)
    end

    it "moved 1 unit on Y axis" do
      robot.send(:place, "4,2,NORTH")
      robot.send(:move)
      expect(STDOUT).to receive(:puts).with("4,3,NORTH")
      robot.send(:report)
    end
  end
end
