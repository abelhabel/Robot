require './spec_helper'

describe Battery do
  before :each do
    @robot = Robot.new
    @battery = Battery.new('Battery', 25)
  end

  describe "#recharge" do
    it "Shield should be recharged by amount" do
      @robot.wound(30)
      @battery.recharge(@robot)
      expect(@robot.shield).to eq(@robot.max_shield - 20)
    end
  end

end