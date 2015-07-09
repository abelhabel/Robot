class Weapon < Item

  attr_reader :name, :weight, :damage

  def initialize(name, weight, damage)
    @name = name
    @weight = weight
    @damage = damage
  end

  def hit(who)
    who.wound(@damage)
  end

end
