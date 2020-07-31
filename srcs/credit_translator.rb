class CreditTranslator
  include Numerals
  include SentanceIdentifier

  attr_accessor :aliases, :definitions

  def initialize
    @aliases = {}
    @definitions = {}
  end

  def add_alias(alis_sentance)
    a = resolve_alias_sentance(alis_sentance)

    raise 'Invalid alis value' unless valid_number?(a.quantity)

    @aliases[a.subject] = a.quantity
  end

  def add_definition(definition_sentance)
    d = resolve_definition_sentance(definition_sentance)

    raise 'Invalid definition value' unless valid_number?(a.quantity)

    @definitions[a[1]] = calc_definition_value(a[0], a[3])
  end

  def answer_question(question_sentance)
    q = resolve_question_sentance(question_sentance)
    value = calc_question_value(q.quantity, q.amount)

    gen_answer_string(q.subject, value)
  end

  private

  def calc_definition_value(quantity, amount)
    amount.to_f / resolve_number(quantity)
  end

  def calc_question_value(quantity, amount)
    resolve_number(quantity) * resolve_definition_multiplier(amount)
  end

  def resolve_definition_multiplier(amount)
    @definitions[amount] || 1
  end

  def gen_answer_string(subject, value)
    "#{subject} is #{value}"
  end
end