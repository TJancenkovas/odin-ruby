def caesar_cipher(string, cipher)

  string.split("").map do |char|
    if is_letter?(char)
      if /[[:lower:]]/.match(char)
        char = shift_char(char.ord - 32, cipher)
        char = char.downcase

      else
        char = shift_char(char.ord, cipher)
      end
    end
    char
  end.join("")
end

def shift_char(char_ord, cipher)
  char_ord += cipher
  #Handling looping upwards
  if char_ord > 90
    char_ord = 64 + (char_ord - 90)
  #Handling looping downwards
  elsif char_ord < 65
    char_ord = 91 - (65 - char_ord)
  else
    char_ord
  end
  char_ord.chr
end

def is_letter?(char)
  char.match?(/[a-zA-Z]/)
end

puts caesar_cipher("What the dog doin?", -11)
