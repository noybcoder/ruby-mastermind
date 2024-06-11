# frozen_string_literal: true

require_relative 'board'
require_relative 'visualizable'

class Game
  include Visualizable
  attr_accessor :board, :guess_validator

  ROUND_LIMIT = 12

  def initialize(board)
    @board = board
  end

  def win?(round)
    board.key_pegs_tracker[round].all?(1)
  end

  def lose?
    board.code_pegs_tracker.size.eql?(ROUND_LIMIT) && !win?
  end

  def play
    round = 0
    loop do
      puts "Round #{round + 1}"
      board.update_code_pegs_tracker
      board.update_key_pegs_tracker(round)
      board.display_board_headers
      puts '--------------------------------------------------------------------'
      board.display_round_summary(round)
      puts '--------------------------------------------------------------------'
      puts "\n\n"
      if win?(round)
        puts 'You win!'
        break
      elsif lose?
        puts 'You lose!'
        break
      end
      round += 1
    end
  end
end

board = Board.new
game = Game.new(board)
game.play
