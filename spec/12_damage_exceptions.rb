require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @weapon = PlasmaCannon.new
  end

  describe "#heal!" do
    it "should throw error" do
      expect(lambda {@robot.attack!(@weapon)}).to raise_error
    end
  end

end
