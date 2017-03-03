class Car < ActiveRecord::Base
  validates_presence_of :direction, :speed

  def turn(new_direction)
    self.direction = new_direction
  end

  def brake
    self.speed = 0
  end

  def accelerate
    self.speed = [speed + 10, 100].min
  end

  # Other, car-related activities ...
end
