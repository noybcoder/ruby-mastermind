require_relative 'board'

class Game

  attr_accessor :board
  def initialize(board)
    @board = board
  end

  def update_code_pegs_tracker
    validator = {}
    validator[*board.code_pegs_tracker] = 1
    validator
  end
end

# board = Board.new
# game = Game.new(board)
# board.update_code_pegs_tracker
# p game.update_guess_validator
