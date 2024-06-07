# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require_relative 'visualizable'
require_relative 'codemaker'
require_relative 'codebreaker'
require_relative 'errors'

class Board
  include Visualizable, CustomErrors

  class Peg
    attr_reader :code_pegs, :key_pegs

    def initialize
      @code_pegs = Array(1..6)
      @key_pegs = Array(1..2)
    end
  end

  class << self
    attr_accessor :board_count
  end

  private_constant :Peg
  BOARD_LIMIT = 1
  @board_count = 0

  attr_accessor :code_pegs_tracker, :key_pegs_tracker
  attr_reader :secret_code, :codemaker, :codebreaker

  def initialize
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @secret_code = codemaker.select_code
    @code_pegs_tracker = []
    @key_pegs_tracker = []
    self.class.board_count += 1

    handle_game_violations(BoardLimitViolation, self.class.board_count, BOARD_LIMIT)
  end

  def update_code_pegs_tracker
    code_pegs_tracker << codebreaker.select_code
  end

end

# board = Board.new
# p board.secret_code

# board.update_code_pegs_tracker
# p board.code_pegs_tracker
