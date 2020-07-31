# frozen_string_literal: true

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
      begin
        evaluate_line(line)
      rescue StandardError
        no_idea
      end
    end
  end

  def repl
    loop do
      line = gets.strip!

      break if line == 'exit'

      begin
        evaluate_line(line)
      rescue StandardError
        no_idea
      end
    end
  end

  def evaluate_line(line)
    if alias_sentance?(line)
      @credit_translator.add_alias(line)
    elsif definition_sentance?(line)
      @credit_translator.add_definition(line)
    elsif question_sentance?(line)
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
