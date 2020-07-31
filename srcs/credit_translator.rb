require 'numerals'
require 'sentance_identifier'

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
    d = resolve_definition_sentance(@aliases, definition_sentance)

    raise 'Invalid definition value' unless valid_number?(d.quantity)

    @definitions[d.subject] = calc_definition_value(d.quantity, d.amount)
  end

  def answer_question(question_sentance)
    q = resolve_question_sentance(@aliases, question_sentance)

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
    "#{subject} is #{strip_trailing_zero(value)}"
  end

  def strip_trailing_zero(n)
    n.to_s.sub(/\.?0+$/, '')
  end
end
