require 'minitest/autorun'
require 'credit_translator'
require 'pry'

class CreditTranslatorTest < Minitest::Test
  def test_additions
    ct = setup

    assert ct.aliases['glob'] == 'I'
    assert ct.definitions['Silver'] == 34
    assert ct.definitions['Gold'] == 50
  end

  def test_questions
    ct = setup

    assert ct.answer_question('how much is Silver') == 'Silver is 34'
  end

  private

  def setup
    ct = CreditTranslator.new

    ct.add_alias 'glob is I'
    ct.add_definition 'Silver is 34 Credits'
    ct.add_definition 'glob glob Gold is 100 Credits'

    ct
  end
end