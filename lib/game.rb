# frozen_string_literal: true

require_relative 'board'
require_relative 'visualizable'

class Game
  include Visualizable
  attr_accessor :board, :guess_validator

  def initialize(board)
    @board = board
    @guess_validator = []
  end
end

board = Board.new
Game.new(board)
board.update_code_pegs_tracker
p board.code_pegs_tracker
