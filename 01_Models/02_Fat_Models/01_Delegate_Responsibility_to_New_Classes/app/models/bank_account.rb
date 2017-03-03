class BankAccount < ActiveRecord::Base
  validates :balance_in_cents, presence: true
  validates :currency,         presence: true

  def balance_in_other_currency(currency)
    # currency exchange logic ...
  end

  def balance
    balance_in_cents / 100
  end

  def balance_equal?(other_bank_account)
    balance_in_cents == other_bank_account.balance_in_other_currency(currency)
  end
end

# using Single Responsability Principle
class BankAccount < ActiveRecord::Base
  validates :balance_in_cents, presence: true
  validates :currency,         presence: true

  composed_of :balance,
              class_name: 'Money',
              mapping: [
                %w(balance_in_cents amount_in_cents),
                %w(currency currency)
              ]
end
