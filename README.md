# StringSimilarity

StringSimilarity provides a very simple api to compare two strings and return a percentage similarity. It is based on the Sørensen–Dice coefficient (https://en.wikipedia.org/wiki/S%C3%B8rensen%E2%80%93Dice_coefficient)

## Installation

Add this line to your application's Gemfile:

    gem 'string_similarity'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install string_similarity

## Usage

StringSimilarity has two methods, `bigram_score` and `ngram_score`.

`bigram_score` is most useful for strings that do not have spaces in them, e.g. Japanese or Simplified Chinese text.

`ngram_score` is most useful for all other languages.

```ruby

string_1 = 'Translation company in Boulder'
string_2 = 'Translation company in New York'

StringSimilarity.bigram_score(string_1, string_2)
#=> 73
StringSimilarity.ngram_score(string_1, string_2)
#=> 74

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/string_similarity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
