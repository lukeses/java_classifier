class FileRow
  attr_accessor :text, :real_class, :number_of_capital_letters, :number_of_special_characters,
                  :number_of_whitespaces, :average_lenght_of_words, :number_of_keywords,
                  :keywords

  def initialize(line, keywords)
    @keywords = keywords
    @text = marked?(line) ? line[2, line.length] : line
    @real_class = marked?(line) ? :j : :o
    @number_of_capital_letters = line.count 'A-Z'
    @number_of_special_characters = line.count "?<>',?[]}{=)(*&^%$#`~{}"
    @number_of_whitespaces = line.count ' '
    @average_lenght_of_words = count_average_length_of_words(line)
    @number_of_keywords = count_number_of_keywords(line)
  end

  def stats
    [number_of_capital_letters, number_of_special_characters, number_of_whitespaces,
      average_lenght_of_words, number_of_keywords, real_class]
  end

  def self.stats_header
    ['number_of_capital_letters', 'number_of_special_characters', 'number_of_whitespaces',
      'average_lenght_of_words', 'number_of_keywords', 'real_class']
  end

  private

  def marked? line
    line.start_with?('@')
  end

  def count_average_length_of_words line
    return 0 if array_of_words_length(line).count == 0
    score = array_of_words_length(line).reduce(:+).to_f / array_of_words_length(line).count
    score.to_i
  end

  def array_of_words_length line
    array_of_words(line).map{ |word| word.length } || []
  end

  def count_number_of_keywords(line)
    @keywords.map{ |keyword| line.include?(keyword) }.count(true)
  end

  def array_of_words line
    line.split(' ')
  end
end
