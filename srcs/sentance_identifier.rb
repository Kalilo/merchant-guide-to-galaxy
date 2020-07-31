require 'sentance_details'

module SentanceIdentifier
  ALIS_STRICTURE_REGEX = /^\s*(\w+)\s(is|are)\s(\w+)\s*$/

  def is_alias_sentance?(sentance)
    !!(sentance =~ ALIS_STRICTURE_REGEX)
  end

  def is_definition_sentance?(sentance)
    !!(sentance =~ /^(\s*\w+\s)+((is|are)\s(\d+)(\sCredits)\s*)$/)
  end

  def is_question_sentance?(sentance)
    !!(sentance =~ /((how much)|(how many))\s(Credits\s)*(is|are)\s(\w+\s*)+\?*/)
  end

  def resolve_alias_sentance(sentance)
    s = split_alias_sentance(sentance)

    SentanceDetails.new(nil, s[3], s[1])
  end

  def resolve_definition_sentance(aliases, sentance)
    s = split_definition_sentance(sub_in_aliases(aliases, sentance))

    SentanceDetails.new(s[4], clean_numerals(s[1]), s[2])
  end

  def resolve_question_sentance(aliases, sentance)
    subject = extract_question_subject(sentance)
    qa = extract_quantity_and_amount(sub_in_aliases(aliases, subject))

    SentanceDetails.new(qa[1], clean_numerals(qa[0]), subject)
  end

  private

  def clean_numerals(numerals)
    numerals = 'I' if numerals.empty?

    numerals.gsub(/\s/, '')
  end

  def sub_in_aliases(aliases, sentance)
    s = sentance.clone

    aliases.each { |k, v| s.gsub!(k, v) }

    s
  end

  def extract_question_subject(sentance)
    split_question_sentance(sentance)[4]
  end

  def extract_quantity_and_amount(sentance)
    s = split_quantity_and_amount(sentance).reject { |c| c.empty? }

    [extract_quantity(s), extract_amount(s)]
  end

  def extract_quantity(split_sentance)
    split_sentance.size > 1 ? split_sentance.first : 'I'
  end

  def extract_amount(split_sentance)
    split_sentance.last
  end

  def split_question_sentance(sentance)
    sentance.split /((how much)|(how many))\s(Credits\s)*(is|are)\s((\w+\s*)+)\b/
  end

  def split_quantity_and_amount(sentance)
    sentance.split /(([IVXLCDM]\s*)+)*\s*\b(\w+)*/
  end

  def split_definition_sentance(sentance)
    sentance.split /([IVXLCDM\s]+)\s(\w+)\s(is|are)\s(\d+)/
  end

  def split_alias_sentance(sentance)
    sentance.split ALIS_STRICTURE_REGEX
  end
end