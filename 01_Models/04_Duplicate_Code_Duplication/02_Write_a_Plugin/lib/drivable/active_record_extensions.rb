module Drivable
  module ActiveRecordExtensions
    module ClassMethods
      def drivable
        validates_presence_of :direction, :speed

        include ActiveRecordExtensions::InstanceMethods
      end
    end

    module InstanceMethods
      def turn(new_direction)
        self.direction = new_direction
      end

      def brake
        self.speed = 0
      end

      def accelerate
        self.speed = [speed + 10, 100].min
      end
    end
  end
end
