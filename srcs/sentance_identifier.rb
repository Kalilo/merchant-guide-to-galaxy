module SentanceIdentifier
  ALIS_STRICTURE_REGEX = /^\s*(\w+)\s(is|are)\s(\w+)\s*$/

  def is_alias_sentance?(sentance)
    !!(sentance =~ ALIS_STRICTURE_REGEX)
  end

  def is_definition_sentance?(sentance)
    !!(/^(\s*\w+\s)+((is|are)\s(\d+)(\sCredits)\s*)$/)
  end

  def is_question_sentance?(sentance)
    !!(/((how much)|(how many))\s(Credits\s)*(is|are)\s(\w+\s*)+\?*/)
  end

  def resolve_alias_sentance(sentance)
    s = split_alias_sentance(sentance)

    [ s[1], s[3] ]
  end

  def resolve_definition_sentance(aliases, sentance)
    s = split_alias_sentance(sub_in_aliases(aliases, sentance))

    [ clean_numerals(s[1]), s[2], s[4] ]
  end

  def resolve_question_sentance(aliases, definitions, sentance)
    #TODO
  end

  private

  def clean_numerals(numerals)
    numerals = 'I' if numerals.empty?

    numerals..gsub(/\s/, '')
  end

  def sub_in_aliases(aliases, sentance)
    s = sentance.clone

    aliases.each { |k, v| s.gsub!(k, v) }

    s
  end

  def split_definition_sentance(sentance)
    sentance.split /([IVXLCDM\s]+)\s(\w+)\s(is|are)\s(\d+)/
  end

  def split_alias_sentance(sentance)
    sentance.split ALIS_STRICTURE_REGEX
  end
end