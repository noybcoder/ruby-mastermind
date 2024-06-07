require_relative 'board'

class Game

  attr_accessor :board
  def initialize(board)
    @board = board
    @guess_validator = []
  end

  def validate_guess
    board.secret_code
  end
end

# board = Board.new
# game = Game.new(board)
# board.update_code_pegs_tracker
# p board.secret_code
# p board.code_pegs_tracker

secret_code = [5, 5, 6, 6]
code_pegs = [1, 2, 5, 3]
output = []

secret_code.each do |answer|
  code_pegs.each_index.select do |guess, index|
    output << index if answer == guess
  end
end
p output
