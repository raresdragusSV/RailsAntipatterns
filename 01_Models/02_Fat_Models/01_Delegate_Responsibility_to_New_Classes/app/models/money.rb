class Money
  include Comparable
  attr_accessor :amount_in_cents, :currency

  def initialize(amount_in_cents, currency)
    self.amount_in_cents = amount_in_cents
    self.currency        = currency
  end

  def in_currency(other_currency)
    # currency exchange logic ...
  end

  def amount
    amount_in_cents / 100
  end

  def <=>(other_money)
    amount_in_cents <=> other_money.in_currency(currency).amount_in_cents
  end
end
