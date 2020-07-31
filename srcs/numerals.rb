module Numerals
  VALUES = { i: 1, v: 5, x: 10, l: 50, c: 100, d: 500, m: 1000 }.freeze
  LETTERS = VALUES.keys.map { |k| k.to_s.upcase }

  def valid_number?(number)
    valid_letters?(number) && valid_sequence?(number)
  end

  def valid_letters?(number)
    !!(number =~ /^[IXCMDLV]+$/)
  end

  def valid_sequence?(number)
    valid_repetitions?(number) && valid_subtractions?(number)
  end

  # Assumes number is already valid
  def resolve_number(number)
    split_components(number).map { |part| resolve_part(part) }.inject(:+)
  end

  private

  def resolve_part(part)
    part.size == 2 ? resolve_subtractive_pair(part) : resolve_letter(part)
  end

  def resolve_subtractive_pair(number)
    parts = number.chars

    resolve_letter(parts[1]) - resolve_letter(parts[0])
  end

  def resolve_letter(letter)
    VALUES[letter.downcase.to_sym]
  end

  def split_components(number)
    number.split(/(I[VX]|X[LC]|C[XM])|([IVXLCDM])/).reject { |c| c.empty? }
  end

  def valid_repetitions?(number)
    !(number =~ /I{4,}|X{4,}|C{4,}|M{4,}|D{2,}|L{2,}|V{2,}/)
  end

  def valid_subtractions?(number)
    !(number =~ /I[LCDM]|X[DM]|V[XLCDM]|L[CDM]|DM|I{2,}[VX]|X{2,}[LC]|C{2,}[DM]/)
  end
end
