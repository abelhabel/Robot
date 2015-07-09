require_relative 'dead_error'
require_relative 'attack_error'
require_relative 'item'
class Robot
  
  attr_accessor :equipped_weapon
  attr_reader :name, :items, :max_health, :default_attack, :capacity,:position, :items_weight, :health

  def initialize()
    @name = "Robot"
    @position = [0,0]
    @items = []
    @items_weight = 0
    @capacity = 250
    @health = 100
    @max_health = 100
    @default_attack = 5
    @equipped_weapon = nil
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    return false if (@items_weight + item.weight > @capacity)
    puts item.class
    @equipped_weapon = item.class < Weapon ? item : nil
    @items << item
    @items_weight += item.weight
  end

  def wound(amount)
    @health -= amount
    @health = @health < 0 ? 0 : @health
  end

  def heal(amount)
    @health += amount
    @health = @health > @max_health ? @max_health : @health
  end

  def heal!(amount)
    if @health <= 0
      DeadError.dead?(self)
    end
  end

  def attack(enemy)
    if @equipped_weapon
      @equipped_weapon.hit(enemy)
    else
      enemy.wound(@default_attack)
    end
  end
  def attack!(enemy)
    if enemy.class != Robot
      AttackError.cannot_attack(self, enemy)
    end
  end

end
