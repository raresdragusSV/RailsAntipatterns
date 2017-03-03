class Bicycle < ActiveRecord::Base
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

  # Other, bike-related activities ...
end

# using module
class Bicycle < ActiveRecord::Base
  include Drivable

  def top_speed
    20
  end

  def acceleration
    1
  end

  # Other, bike-related activities ...
end
