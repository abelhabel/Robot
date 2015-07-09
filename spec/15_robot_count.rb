require './spec_helper'

describe Robot do
  before :each do
    10.times { Robot.new }
    
  end

  describe "@robots_created" do
    it "10 robots should be created" do
      expect(Robot.robot_count.count).to eq(10)
    end
  end

end