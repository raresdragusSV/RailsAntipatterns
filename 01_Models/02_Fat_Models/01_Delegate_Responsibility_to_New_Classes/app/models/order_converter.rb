class OrderConverter
  attr_reader :order

  def initialize(order)
    @order = order
  end

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
