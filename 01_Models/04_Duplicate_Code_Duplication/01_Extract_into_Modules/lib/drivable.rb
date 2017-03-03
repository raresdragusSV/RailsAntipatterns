module Drivable
  extend ActiveSupport::Concern

  class TemplateError < RuntimeError
  end

  included do
    validates :direction, presence: true
    validates :speed,     presence: true
  end

  def turn(new_direction)
    self.direction = new_direction
  end

  def brake
    self.speed = 0
  end

  def accelerate
    self.speed = [speed + acceleration, top_speed].min
  end

  def top_speed
    raise TemplateError, 'The Drivable module requires the including class ' \
                         'to define a top_speed method'
  end

  def acceleration
    raise TemplateError, 'The Drivable module requires the including class ' \
                         'to define an acceleration method'
  end
end
