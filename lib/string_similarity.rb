require "string_similarity/version"

class StringSimilarity

  MIN_NGRAM_LENGTH = 2

  def self.ngram_score(string_1, string_2)
    ngram_length = (string_1.length.to_f * 0.1).round
    ngram_length = [MIN_NGRAM_LENGTH, ngram_length].max
    score(string_1, string_2, ngram_length)
  end

  def self.bigram_score(string_1, string_2)
    score(string_1, string_2, MIN_NGRAM_LENGTH)
  end

  private

  def self.score(string_1, string_2, ngram_length)
    string_1 = String.new(string_1)
    string_2 = String.new(string_2)

    cleaned_string_1 = remove_special_characters(string_1)
    cleaned_string_2 = remove_special_characters(string_2)

    string_1_ngrams = cleaned_string_1.each_char.each_cons(ngram_length).to_set
    string_2_ngrams = cleaned_string_2.each_char.each_cons(ngram_length).to_set

    overlap = (string_1_ngrams & string_2_ngrams).size
    total = string_1_ngrams.size + string_2_ngrams.size
    return 0 unless overlap > 0 && total > 0

    sorensen_dice = overlap * 2.0 / total

    score = (sorensen_dice * 100).round
    normalize_score(score, string_1, string_2)
  end

  def self.remove_special_characters(phrase)
    phrase.gsub!(/[[:punct:]<>]+/, "") # remove all punctuation
    phrase.strip! # remove trailing and leading white space
    phrase.gsub!(/\s+/, " ") # replace extended white space with one space
    phrase.downcase
  end

  def self.capitalization_differences(original_phrase, found_phrase)
    (original_phrase.downcase == found_phrase || found_phrase.downcase == original_phrase ||
      original_phrase.upcase == found_phrase || found_phrase.upcase == original_phrase) &&
      found_phrase != original_phrase
  end

  def self.normalize_score(score, original_phrase, found_phrase)
    capitalization_differences(original_phrase, found_phrase) ? score - 1 : score
  end


end
