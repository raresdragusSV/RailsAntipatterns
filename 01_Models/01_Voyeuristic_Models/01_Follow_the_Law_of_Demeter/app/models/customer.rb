class Customer < ActiveRecord::Base
  has_one :address
  has_many :invoices

  # refactoring using Law of Demeter,
  # also known as the Principle of Least Knowledge

  def street
    address.street
  end

  def city
    address.city
  end

  def state
    address.state
  end

  def zip_code
    address.zip_code
  end
end

# refactoring using delegate

class Customer < ActiveRecord::Base
  has_one :address
  has_many :invoices

  delegate :street, :city, :state, :zip_code, to: :address
end
