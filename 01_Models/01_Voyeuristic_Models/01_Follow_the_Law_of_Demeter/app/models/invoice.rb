class Invoice < ActiveRecord::Base
  belongs_to :customer

  # refactoring using Law of Demeter,
  # also known as the Principle of Least Knowledge

  def customer_name
    customer.name
  end

  def customer_street
    customer.street
  end

  def customer_city
    customer.city
  end

  def customer_state
    customer.state
  end

  def customer_zip_code
    customer.zip_code
  end
end

# refactoring using delegate

class Invoice < ActiveRecord::Base
  belongs_to :customer

  delegate :name, :street, :city, :state, :zip_code,
           to: :customer, prefix: true
end
