reqire 'credit_translator'

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

      evaluate_line(line) rescue no_idea
    end
  end

  def evaluate_line(line)
    case (line)
    when is_alias_sentance?(line)
      @credit_translator.add_alias(line)
    when is_definition_sentance?(line)
      @credit_translator.add_definition(line)
    when is_question_sentance?(line)
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