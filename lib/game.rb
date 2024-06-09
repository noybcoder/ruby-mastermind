require_relative 'board'
require_relative 'visualizable'

class Game
  include Visualizable
  attr_accessor :board, :guess_validator
  def initialize(board)
    @board = board
    @guess_validator = []
  end

  def validate_guess
    board.code_pegs_tracker[0].each_with_index do | guess, index |
      if guess == board.secret_code[index]
        guess_validator[index] = 1
      elsif board.code_pegs_tracker[0].tally[guess] <= board.secret_code.tally.fetch(guess, 0)
        guess_validator[index] = 0
      end
    end
  end

  # def display_key_codes
  #   guess_validator.each{ |peg| puts set_key_peg_colors('X')[peg] }
  # end
end

board = Board.new
game = Game.new(board)
board.update_code_pegs_tracker
game.validate_guess
# game.display_key_codes
