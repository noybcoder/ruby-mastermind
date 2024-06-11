# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require_relative 'visualizable'
require_relative 'codemaker'
require_relative 'codebreaker'
require_relative 'errors'

class Board
  include CustomErrors
  include Visualizable

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
    @secret_code = codemaker.set_secret_code
    @code_pegs_tracker = []
    @key_pegs_tracker = []
    self.class.board_count += 1

    handle_game_violations(BoardLimitViolation, self.class.board_count, BOARD_LIMIT)
  end

  def update_code_pegs_tracker
    code_pegs_tracker << codebreaker.make_guesses
  end

  def update_key_pegs_tracker(round)
    key_pegs_tracker << sort_key_pegs(round)
  end

  private

  def sort_key_pegs(round)
    validated_guess = codemaker.validate_guess(code_pegs_tracker[round], secret_code)
    validated_guess.sort.reverse
  end
end
