require 'spec_helper'

describe StringSimilarity do

  describe 'short phrases' do

    it 'returns 100 if there is no difference' do
      string = 'hello'
      expect(StringSimilarity.score(string, string)).to eq(100)
    end

    it 'returns 99 if the original is lowercase and found is uppercase' do
      string_1 = 'test'
      string_2 = 'TEST'

      expect(StringSimilarity.score(string_1, string_2)).to eq(99)
    end

    it 'returns 99 when found is uppercase and original is capitalized' do
      string_1 = 'Email'
      string_2 = 'EMAIL'

      expect(StringSimilarity.score(string_1, string_2)).to eq(99)
    end

    it 'returns 99 if original is uppercase and found is capitalized' do
      string_1 = 'EMAIL'
      string_2 = 'Email'

      expect(StringSimilarity.score(string_1, string_2)).to eq(99)
    end

    it 'returns 99 if original is uppercase and found is lowercase' do
      string_1 = 'EMAIL'
      string_2 = 'email'

      expect(StringSimilarity.score(string_1, string_2)).to eq(99)
    end

    it 'returns 86' do
      string_1 = 'test'
      string_2 = 'tests'

      expect(StringSimilarity.score(string_1, string_2)).to eq(86)
    end

    it 'returns an 86 with capitalization differences' do
      string_1 = 'test'
      string_2 = 'Tests'

      expect(StringSimilarity.score(string_1, string_2)).to eq(86)
    end

    it 'returns 6' do
      string_1 = 'test'
      string_2 = 'no way is this like the original string'

      expect(StringSimilarity.score(string_1, string_2)).to eq(6)
    end

  end

  describe 'long phrases' do

    it 'returns 0 when strings are of much different length' do
      string_1 = 'We are committed to providing the best products and friendliest customer service. If you should have any questions about ordering or a question about any of our great products, please feel free to contact us with the information provided below.'
      string_2 = "INFORMATION WE COLLECT. Roomster collects information our users submit to us such as their name and e-mail address to allow us to identify users and notify them of changes or updates to our service. We also collect personal information submitted by our users in filling out their profile on the service such as gender, state of residence, occupation, interests, etc. We collect this personal information when our users: (a) sign up as a member; (b) make changes to their member profile information; and (c) send e-mail messages, forms, or other information to us via Roomster. Members may choose to provide additional information beyond their basic profile for their personal and professional profiles. Providing additional information beyond what is required at registration is entirely optional, but enables our users to better identify each other and more effectively connect and interact with their network.  Roomster also collects information from users that is unique, but cannot be linked to a specific individual, such as IP address and browser type. A user's session will be tracked, but each user will remain anonymous. We gather this information on all visitors to Roomster.com for systems administration purposes and to track user trends, such as our most popular features. We do not link IP addresses to any personally identifiable information."

      expect(StringSimilarity.score(string_1, string_2)).to eq(0)
    end

    it 'returns 0 when the phrase is too long to come up with an accurate percentage' do
      string_1 = 'A variety of shopping centers housing popular merchants are just a few miles from the oceanfront, offering varied dining options, large retailers and a number of specialty stores. From classic fashions at Talbots to gourmet foods and cookware at Williams-Sonoma, your refined tastes are sure to be rewarded.'
      string_2 = "Nice is an attractive city situated on the well-reputed French Riviera – France’s Mediterranean coast. There are many beautiful beaches within driving distance as well as a varied array of shopping centers, historical attractions, and museums to satiate the appetite of the cultured traveler. Since it is one of France's largest cities, it is also a major business hub. With both tourists and business executives traveling to Nice, it pays for travelers to plan for their transportation needs in advance. To travel in comfort for an affordable cost, use Blacklane's limousine service for Nice."

      expect(StringSimilarity.score(string_1, string_2)).to eq(0)
    end

    it 'returns 0 when the phrases dont match enough' do
      string_1 = 'We are committed to providing the best products and friendliest customer service. If you should have any questions about ordering or a question about any of our great products, please feel free to contact us with the information provided below.'
      string_2 = 'We strive to provide the best music experience for our listeners, and are passionate about providing the largest and broadest catalog of digital music.^^<br />^^'

      expect(StringSimilarity.score(string_1, string_2)).to eq(0)
    end

    it 'returns a higher match when the phrases are close' do
      string_1 = 'A taxi alternative in Prague'
      string_2 = 'A taxi alternative in Munich'

      expect(StringSimilarity.score(string_1, string_2) > 75).to eq(true)
    end

  end

  describe 'special characters' do

    it 'strips out carats to mark text to not translate' do
      string_1 = 'Back to Home'
      string_2 = '<<Back to Main>>'

      expect(StringSimilarity.score(string_1, string_2)).to eq(64)
    end

    it 'strips out punctuation' do
      string_1 = 'Back to Home!?'
      string_2 = 'Back to Main...'

      expect(StringSimilarity.score(string_1, string_2)).to eq(64)
    end

    it 'converts extended whitespace to one space' do
      string_1 = 'Back to Home'
      string_2 = 'Back to     Main'

      expect(StringSimilarity.score(string_1, string_2)).to eq(64)
    end

    it 'strips beginning and trailing whitespace' do
      string_1 = 'Back to Home '
      string_2 = ' Back to Main'

      expect(StringSimilarity.score(string_1, string_2)).to eq(64)
    end

  end

  describe 'phrases with numbers' do

    it 'does not raise FloatDomainError' do
      string_1 = '1 '
      string_2 = '< 1'

      expect(StringSimilarity.score(string_1, string_2)).to eq(0)
    end

    it 'compares strings that have a number within them' do
      string_1 = 'I work at 1035 Pearl St.'
      string_2 = 'I work at 1045 Pearl St.'

      expect(StringSimilarity.score(string_1, string_2) > 90).to eq(true)
    end

  end

end