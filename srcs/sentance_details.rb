class SentanceDetails
  attr_accessor :amount, :quantity, :subject

  def initialize(amount, quantity, subject)
    @amount = amount
    @quantity = quantity
    @subject = subject
  end
end
