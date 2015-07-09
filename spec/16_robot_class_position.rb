require './spec_helper'

describe Robot do

  describe "#robots position" do
    it "return 1 robot" do
      @robot = Robot.new
      @robot.move_up
      expect(Robot.get_robots_at(0,1).count).to eq(1)
    end
  end

end