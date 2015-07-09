require_relative 'dead_error'
require_relative 'attack_error'
require_relative 'item'
class Robot
  
  attr_accessor :equipped_weapon
  attr_reader :name, :items, :max_health, :default_attack, :capacity,:position, :items_weight, :health
  attr_reader :shield, :max_shield
  #create constants for variables that can't change, like min_health, max_health etc
  @@robots_created = []

  def self.robot_count
    @@robots_created
  end

  def self.get_robots_at(x, y)
    arr = []
    @@robots_created.each{ |r| arr << r if (r.position[0] == x && r.position[1] == y) }
    arr
  end

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
    @shield = 50
    @max_shield = 50
    @@robots_created << self
    @special_weapon = PhaseGrenade.new

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
    @equipped_weapon = item.class < Weapon ? item : nil
    @items << item
    @items_weight += item.weight
  end

  def wound(amount, shield_penetration = false)
    remainder = 0
    if !shield_penetration
      remainder = @shield - amount
      @shield = remainder < 0 ? 0 : @shield - amount
    else
      remainder -= amount
    end
    @health -= remainder < 0 ? remainder.abs : 0
    @health = @health < 0 ? 0 : @health
  end

  def heal_shield(amount) 
    @shield += amount
    @shield = @max_shield if @shield > @max_shield
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

  def special_attack(x, y)
    robots = scan(x, y)
    puts robots.inspect
    robots.each { |r| r[0].wound(@special_weapon.damage, @special_weapon.shield_penetration)}
  end

  def scan(offset_x = 0, offset_y = 0)
    robots = []
    [[0, 1], [-1,0], [1,0], [0,-1]].each do |co|
      r = Robot.get_robots_at(self.position[0] + co[0] + offset_x, self.position[1] + co[1] + offset_y)
      robots << r if r.any?{ |e| e.class <= Robot }
    end
    robots
  end

end

