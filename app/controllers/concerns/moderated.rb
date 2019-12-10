module Moderated
  class Moderator
    attr_accessor :bad_words_list, :matched_words

    BAD_WORDS = File.dirname(__FILE__) + "/bad_words.txt"

    def initialize
      load_list
      self.matched_words = []
    end

    def test_contains_curse(string)
      essence = string.to_s.downcase.gsub(/[^\.\'a-zA-Z]/, '')
      self.bad_words_list.each do |b|
        matched_words.push(b) if string.match?(Regexp.new(b, true))
      end
    end
  
    def censor_vowel(string)
      new_string = string
      matched_words.each do |m|
        string.scan(m).each do |o| 
          new_string = new_string.gsub(o, o.gsub(/[aeiou]/i, '*'))
        end
      end
      new_string
    end
  
    def flag_if(obj)
      if obj.class == User
        obj.update(flag:true, username:censor_vowel(obj.username)) if test_contains_curse(obj.username)
      elsif obj.class == Traveler
        obj.update(flag:true, name:censor_vowel(obj.name)) if test_contains_curse(obj.name)
        obj.update(flag:true, descript:censor_vowel(obj.descript)) if test_contains_curse(obj.descript)
      elsif obj.class == Journey
        obj.update(flag:true, name:censor_vowel(obj.name)) if test_contains_curse(obj.name)
      elsif obj.class == Item || obj.class == Space
        obj.update(flag:true, noun:censor_vowel(obj.noun)) if test_contains_curse(obj.noun)
        obj.update(flag:true, adjective:censor_vowel(obj.adjective)) if test_contains_curse(obj.adjective)
        obj.update(flag:true, descript:censor_vowel(obj.descript)) if test_contains_curse(obj.descript)
      end
    end
  
    private
  
    def load_list
      self.bad_words_list = IO.readlines(BAD_WORDS).map {|w|w.gsub(/\n/, '')} 
    end
  end
end