def substring (substring, dictionary)

  substring = substring.downcase.split(" ")

  substring.reduce(Hash.new()) do | count, substr_word | #Could have used #scan here
    dictionary.each do |dict_word|
      if substr_word.match?(dict_word)
        if count[dict_word]
          count[dict_word] += 1
        else
          count[dict_word] = 1
        end
      end
    end
    count
  end
end


substring = "Howdy partner, sit down! How's it going?"
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts (substring(substring, dictionary))

