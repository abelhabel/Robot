class Battery < Item
  
  attr_reader :recharge_val

  def Initialize(name, weight)
    super(name, weight)
  end

  def recharge(who)
    @recharge_val = 10
    who.heal_shield(@recharge_val)
  end

end