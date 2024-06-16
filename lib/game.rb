# frozen_string_literal: true

require_relative 'board'
require_relative 'npccodebreaker'

class Game
  attr_accessor :board

  ROUND_LIMIT = 11

  def initialize(board)
    @board = board
  end

  def play
    round = 0
    loop do
      puts "Round #{round + 1}"
      board.update_code_pegs_tracker(round)
      board.update_key_pegs_tracker(round)
      board.display_board(round, board.code_pegs_tracker, board.key_pegs_tracker)
      if win?(round)
        display_win_message
        break
      elsif lose?(round)
        display_lose_message
        break
      end
      round += 1
    end
  end

  private

  def win?(round)
    board.key_pegs_tracker[round].all?(0)
  end

  def lose?(round)
    round.eql?(ROUND_LIMIT) && !win?(round)
  end

  def display_win_message
    puts "Congratulations, codebreaker! You have cracked the code!\n\n"
  end

  def reveal_secret_code
    board.display_secret_code(board.secret_code)
  end

  def display_lose_message
    puts "Oops, the secret code is #{reveal_secret_code}. Better luck next time!\n\n"
  end
end

board = Board.new
game = Game.new(board)
puts game.play
