class SentanceDetails
  attr_accessor :amount, :quantity, :subject

  def initialize(amount, quantity, subject)
    @amount = amount
    @subject = subject
    @quantity = quantity
  end
end