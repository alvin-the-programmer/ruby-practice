class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  def alert_invalid_move(letter)
    puts "#{name}, #{letter} is not a valid move!"
    puts "Your guess must be a letter of the alphabet."
    puts "You must be able to form a word starting with the new fragment."
    puts
  end

  def guess(fragment)
    prompt(fragment)
    gets.chomp.downcase
  end

  def prompt(fragment)
      puts "The current fragment is '#{fragment}'."
      print "Add a letter: "
  end

end
