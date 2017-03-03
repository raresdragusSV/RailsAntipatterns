class Car < ActiveRecord::Base
  validates :direction, presence: true
  validates :speed,     presence: true

  def turn(new_direction)
    self.direction = new_direction
  end

  def brake
    self.speed = 0
  end

  def accelerate
    self.speed = speed + 10
  end

  # Other, car-related activities ...
end

# using module
class Car < ActiveRecord::Base
  include Drivable

  def top_speed
    100
  end

  def acceleration
    10
  end

  # Other, car-related activities ...
end
