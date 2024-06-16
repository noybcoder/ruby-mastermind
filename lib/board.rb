# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require_relative 'visualizable'
require_relative 'npccodemaker'
require_relative 'playercodebreaker'
require_relative 'npccodebreaker'
require_relative 'playercodemaker'
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

  attr_accessor :code_pegs_tracker, :key_pegs_tracker, :character
  attr_reader :secret_code, :codemaker, :codebreaker

  def initialize
    # @character = nil
    # @codemaker = @character == 1? PlayerCodeMaker.new: NPCCodeMaker.new
    # @codebreaker = @character == 1? NPCCodeBreaker.new: PlayerCodeBreaker.new
    @codemaker = NPCCodeMaker.new
    @codebreaker = PlayerCodeBreaker.new
    @secret_code = codemaker.set_secret_code
    @code_pegs_tracker = []
    @key_pegs_tracker = []
    self.class.board_count += 1

    handle_game_violations(BoardLimitViolation, self.class.board_count, BOARD_LIMIT)
  end

  def update_code_pegs_tracker(round = nil)
    code_pegs_tracker << codebreaker.make_guesses(round)
  end

  def update_key_pegs_tracker(round)
    key_pegs_tracker << finalize_validated_guess(round)
    return unless codebreaker.instance_of?(NPCCodeBreaker)

    codebreaker.filter_possible_guesses(code_pegs_tracker[round], get_validated_guess(round))
  end

  private

  def finalize_validated_guess(round)
    guess = get_validated_guess(round)
    validated_guess = guess.flat_map.with_index { |count, index| [index] * count }
    validated_guess << nil until validated_guess.size == secret_code.size
    validated_guess
  end

  def get_validated_guess(round)
    codemaker.validate_guess(code_pegs_tracker[round], secret_code)
  end
end
