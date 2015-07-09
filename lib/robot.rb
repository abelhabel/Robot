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
    item.feed(self) if (item.class <= BoxOfBolts && self.health <= 80)
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
    @health = [0, @health - remainder].max
  end

  def heal_shield(amount) 
    @shield = [@max_shield, @shield + amount].max
  end

  def heal(amount)
    @health = [@max_health, @health + amount].max
  end

  def heal!(amount)
    if @health <= 0
      DeadError.dead?(self)
    end
  end

  def attack(enemy)
    # print scan.class
    return false if !can_attack(enemy)
    if @equipped_weapon
      @equipped_weapon.hit(enemy)
      @equipped_weapon = nil
    else
      enemy.wound(@default_attack)
    end
  end

  def attack!(enemy)
    if enemy.class != Robot
      AttackError.cannot_attack(self, enemy)
    end
  end  

  def can_attack(target)
    x_offset = @equipped_weapon ? @equipped_weapon.range : 0
    y_offset = @equipped_weapon ? @equipped_weapon.range : 0
    x = (self.position[0] - target.position[0]).abs
    y = (self.position[1] - target.position[1]).abs
    (x <= 1  + x_offset && y <= 1 + y_offset) #can attack diagonally
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

