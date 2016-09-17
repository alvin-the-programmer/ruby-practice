require 'set'
require_relative "player"

class Ghost
  ALPHABET = Set.new(("a".."z").to_a)
  MAX_LOSS_COUNT = 3

  attr_reader :fragment, :players, :dictionary, :losses

  def initialize(*players)
    words = File.readlines("dictionary.txt").map(&:chomp)
    @dictionary = words.to_set
    @players = players
    @losses = {}

    players.each { |player| losses[player] = 0 }
  end

  def currentPlayer
    players.first
  end

  def next_player!
    players.rotate!
    players.rotate! while losses[currentPlayer] == MAX_LOSS_COUNT
  end

  def valid_play?(letter)
    return false unless ALPHABET.include?(letter)
    new_fragment = fragment + letter
    dictionary.any? { |word| word.start_with?(new_fragment) }
  end

  def take_turn(player)
    puts "#{player.name}'s turn"
    letter = player.guess(fragment)

    while !valid_play?(letter)
      player.alert_invalid_move(letter)
      letter = player.guess(fragment)
    end

    fragment << letter
    puts "'#{letter}' added to fragment"
    puts "new fragment: '#{fragment}'"
    puts
  end

  def round_over?
    dictionary.include?(fragment)
  end

  def end_round
    losses[currentPlayer] += 1

    puts
    puts "SCORE:"

    losses.each do |player, number_losses|
      if number_losses == MAX_LOSS_COUNT
        puts "#{player.name} has been eliminated with #{number_losses} losses"
      else
        puts "#{player.name} has #{number_losses} losses"
      end
    end

    puts
  end

  def play_round
    @fragment = ""

    until round_over?
      next_player!
      take_turn(currentPlayer)
    end

    puts "=== ROUND OVER ==="
    puts "'#{fragment}' is in the dictionary."
    puts "#{currentPlayer.name} loses."
    end_round
  end

  def play_game
    play_round until losses.one? { |player, losses| losses < MAX_LOSS_COUNT}

    losses.each do |player, losses|
      if losses < MAX_LOSS_COUNT
        puts "#{player.name} is the Winner!!!"
      end
    end
  end
end

game = Ghost.new(Player.new("Alvin"), Player.new("Simon"), Player.new("Theo"))
game.play_game
