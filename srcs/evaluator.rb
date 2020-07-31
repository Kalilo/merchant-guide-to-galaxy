require 'credit_translator'
require 'sentance_identifier'

class Evaluator
  include SentanceIdentifier

  def initialize
    @credit_translator = CreditTranslator.new
  end

  def run_file(filename)
    file = readfile(filename)

    file.each do |line|
      evaluate_line(line) rescue no_idea
    end
  end

  def repl
    loop do
      line = gets.strip!

      break if line == 'exit'
      puts is_alias_sentance?(line)
      evaluate_line(line) rescue no_idea
    end
  end

  def evaluate_line(line)

    if is_alias_sentance?(line)
      @credit_translator.add_alias(line)
    elsif is_definition_sentance?(line)
      @credit_translator.add_definition(line)
    elsif is_question_sentance?(line)
      puts @credit_translator.answer_question(line)
    else
      puts no_idea
    end
  end

  def readline
    gets.strip!
  end

  def readfile(filename)
    File.readlines(filename).each(&:strip!).reject!(&:empty?)
  end

  def no_idea
    'I have no idea what you are talking about'
  end
end