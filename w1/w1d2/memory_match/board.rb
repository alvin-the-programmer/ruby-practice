require_relative "card"

class Board
  attr_reader :grid

  GRID_LENGTH = 2

  def initialize
    @grid = Array.new(GRID_LENGTH) { Array.new(GRID_LENGTH) }
  end

  def [](position)
    row, column = position
    @grid[row][column]
  end

  def []=(position, mark)
    row, column = position
    @grid[row][column] = mark
  end

  def number_pairs
    (GRID_LENGTH * GRID_LENGTH) / 2
  end

  def shuffle_cards
    cards = [];

    number_pairs.times do |i|
      cards << Card.new(i)
      cards << Card.new(i)
    end

    cards.each { |card| card.hide }
    cards.shuffle;
  end

  def populate
    cards = shuffle_cards

    GRID_LENGTH.times do |row|
      GRID_LENGTH.times do |column|
        position = row, column
        self[position] = cards.pop
      end
    end
  end

  def render
    GRID_LENGTH.times do |row|
      GRID_LENGTH.times do |column|
        position = row, column
        print self[position].face
      end
      puts
    end
  end

end
