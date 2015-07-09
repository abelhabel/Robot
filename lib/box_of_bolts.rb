class BoxOfBolts < Item

  def initialize
    super('Box of bolts',25)
    @heal_val = 20
  end

  def feed(who)
    who.heal(@heal_val)
  end

end
