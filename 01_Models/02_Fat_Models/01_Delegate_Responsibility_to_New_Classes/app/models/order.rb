class Order < ActiveRecord::Base
  def to_xml
    #  ...
  end

  def to_json
    #  ...
  end

  def to_csv
    #  ...
  end

  def to_pdf
    #  ...
  end
end

# Refactoring using SRP: The Single Responsibility Principle

class Order < ActiveRecord::Base
  def converter
    OrderConverter.new(self)
  end
end

# Refactoring using Breaking the Law of Demeter

class Order < ActiveRecord::Base
  delegate :to_xml, :to_json, :to_csv, :to_pdf, to: :converter

  def converter
    OrderConverter.new(self)
  end
end
