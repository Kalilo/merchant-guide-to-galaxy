module SentanceIdentifier
  def is_alias?(sentance)
    !!(sentance =~ /^\s*\w+\s(is|are)\s\w+\s*$/)
  end

  def is_definition?(sentance)
    !!(/^(\s*\w+\s)+((is|are)\s(\d+)(\sCredits)\s*)$/)
  end

  def is_question?(sentance)
    !!(/((how much)|(how many))\s(Credits\s)*(is|are)\s(\w+\s*)+\?*/)
  end
end