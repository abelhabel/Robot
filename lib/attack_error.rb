class AttackError < StandardError
  def self.cannot_attack(attacker, defender)
    raise "#{attacker} cannot attack #{defender} because defender is not a #{attacker.class}"
  end

end