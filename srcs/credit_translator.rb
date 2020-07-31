class CreditTranslator
  include Numerals
  include SentanceIdentifier

  attr_accessor :aliases, :definitions

  def initialize(credits)
    @aliases = {}
    @definitions = {}
  end

  def add_alias(alis_sentance)
    a = split_alias_sentance(alis_sentance)

    raise 'Invalid alis value' unless valid_number?(a.quantity)

    @aliases[a.subject] = a.quantity
  end

  def add_definition(definition_sentance)
    d = split_definition_sentance(definition_sentance)

    raise 'Invalid definition value' unless valid_number?(a.quantity)

    @definitions[a[1]] = calc_definition_value(a[0], a[3])
  end

  private

  def calc_definition_value(quantity, amount)
    amount.to_f / resolve_number(quantity)
  end
end