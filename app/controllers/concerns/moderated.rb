module Moderated
  def test_contains_curse(string)
    regex_test = /shit/i
    string.match?(regex_test)
  end

  def censor_vowel(string)
    regex_test = /shit/i
    new_string = string
    string.scan(regex_test).each do |o| 
      new_string = new_string.gsub(o, o.gsub(/[aeiou]/i, '*'))
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
end