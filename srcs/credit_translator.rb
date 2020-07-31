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

    raise 'Invalid alis value' unless valid_number?(a[1])

    @aliases[a[0]] = a[1]
  end

  def add_definition(definition_sentance)
    a = split_definition_sentance(definition_sentance)

    raise 'Invalid definition value'
  end
end