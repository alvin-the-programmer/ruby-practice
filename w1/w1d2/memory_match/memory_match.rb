require_relative "board"

class Memory_match
  attr_reader :board, :previous_guess, :number_matches

  def initialize
    @board = Board.new()
    @number_matches = 0
    puts number_matches
    board.populate
  end


  def play
    round until over?
  end

  def over?
    number_matches == board.number_pairs
  end

  def round
    board.render
    card1 = guess
    card2 = guess
    check(card1, card2)
    sleep(2)
    system("clear")
  end

  def guess
    card = board[prompt]
    system("clear")
    card.reveal
    board.render
    card
  end

  def prompt
    print "Enter a position: "
    gets.chomp.split(' ').map { |i| i.to_i }
  end

  def check(card1, card2)
    if card1 == card2
      @number_matches += 1
    else
      card1.hide
      card2.hide
    end
  end
end

game = Memory_match.new
game.play
