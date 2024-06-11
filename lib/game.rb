# frozen_string_literal: true

require_relative 'board'

class Game
  attr_accessor :board

  ROUND_LIMIT = 11

  def initialize(board)
    @board = board
  end

  def win?(round)
    board.key_pegs_tracker[round].all?(1)
  end

  def lose?(round)
    round.eql?(ROUND_LIMIT) && !win?(round)
  end

  def display_win_message
    'Congratulations, codebreaker! You have cracked the code!'
  end

  def display_lose_message(_round)
    'Sorry, the codemaker is good. Please try again next time.'
  end

  def play
    round = 0
    loop do
      puts "Round #{round + 1}"
      board.update_code_pegs_tracker
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
end

board = Board.new
game = Game.new(board)
game.play
