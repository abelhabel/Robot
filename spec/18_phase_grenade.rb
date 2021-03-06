require './spec_helper'

describe PhaseGrenade do

  describe "#special_attack" do
    it "return 2 robot" do
      @attacker = Robot.new
      @defender = Robot.new
      @defender.move_up
      @defender.move_up
      @defender.move_up

      @attacker.special_attack(0, 2)
      expect(@defender.health).to eq(70)
    end
  end

end