class Portfolio < ActiveRecord::Base
  def self.close_all!
    all.each do |portfolio|
      unless portfolio.photos.empty?
        raise "Can't close a portfolio with photos."
      end
      portfolio.close!
    end
  end
end

# improve user experience

class Portfolio < ActiveRecord::Base
  def self.close_all!
    all.each do |portfolio|
      unless portfolio.photos.empty?
        raise 'Some of the portfolios have photos.'
      end
    end
    all.each(&:close!)
  end
end

# refactoring

class Portfolio < ActiveRecord::Base
  def self.can_close_all?
    !all.any? { |portfolio| portfolio.photos.empty? }
  end

  def self.close_all
    raise "Can't close a portfolio with photos." unless
      can_close_all?
    all.each(&:close!)
  end
end
