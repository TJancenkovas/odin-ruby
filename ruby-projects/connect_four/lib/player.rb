class Player
  attr_reader :name, :symbol

  def initialize(name, color)
    @name = name
    @symbol = get_symbol(color)
  end

  def get_symbol(color)
    if color == 'red'
      "\u26AA"
    elsif color == 'black'
      "\u26ab"
    else
      nil
    end
  end
end
