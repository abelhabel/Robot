require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @weapon = PlasmaCannon.new
  end

  describe "#heal!" do
    it "should throw error" do
      @robot.wound(160)
      expect(lambda {@robot.heal!(100)}).to raise_error
    end
  end

end
