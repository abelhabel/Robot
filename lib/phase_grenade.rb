class PhaseGrenade < Weapon

  attr_reader :shield_penetration

  def initialize
    super('Phase grenade', 5, 30)
    @shield_penetration = true
    @range = 1
  end

  def attack(x, y)
    Robot.scan(x,y)
  end
end