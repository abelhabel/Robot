require './spec_helper'

describe Robot do

  describe "#scan" do
    it "return 2 robot" do
      @robot1 = Robot.new
      @robot1.move_up
      @robot2 = Robot.new
      @robot2.move_down
      @robot3 = Robot.new
      @robot3.move_up
      @robot3.move_up

      @robot4 = Robot.new
      expect(@robot4.scan.count).to eq(2)
    end
  end

end