require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#wound" do
    it "health should be full when damage is less than current shield" do
      @robot.wound(30)
      expect(@robot.health).to eq(@robot.max_health)
      # expect(@robot.shield).to eq(@robot.max_shield - 30)
    end
    it "shield should be lowered" do
      @robot.wound(30)
      expect(@robot.shield).to eq(@robot.max_shield - 30)
    end
    it "health should be lower than max health if damage is greater than current shield" do
      @robot.wound(60)
      expect(@robot.health).to eq(@robot.max_health -  10)
    end
    it "shield should be 0 when damage is more than max shield" do
      @robot.wound(60)
      expect(@robot.shield).to eq(0)
    end
  end

end
