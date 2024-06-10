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

  def win?
    board.key_pegs_tracker[-1].all?(1)
  end

  def lose?(limit)
    board.code_pegs_tracker.size.eql?(limit) && !win?
  end

  def play
    round = 0
    loop do
      puts "Round #{round + 1}"
      board.update_code_pegs_tracker
      board.update_key_pegs_tracker
      puts "\n"
      display = board.code_pegs_tracker[round].map {|peg| set_code_peg_colors[peg]}
      display.each { |peg| print peg}
      puts "\n\n"
      if win?
        puts 'You win!'
        break
      elsif lose?(12)
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
