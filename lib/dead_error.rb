class DeadError < StandardError
  def self.dead?(who)
    raise "#{who.name} is dead and cannot be healed."
  end
end