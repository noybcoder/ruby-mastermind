# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'
require_relative 'visualizable'

class CodeBreaker < Character
  include Visualizable
  include CustomErrors

  class << self
    attr_accessor :codebreaker_count
  end

  CODEBREAKER_LIMIT = 1
  @codebreaker_count = 0

  attr_accessor :code_combo

  def initialize
    super
    self.class.codebreaker_count += 1
    @code_combo = Array(1..6).repeated_permutation(4).to_a
    handle_game_violations(CodeBreakerLimitViolation, self.class.codebreaker_count, CODEBREAKER_LIMIT)
  end

  def make_guesses
    select_code { prompt }
  end

  def prompt
    puts "Codebreaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to crack the code:"
    gets.chomp
  end

  def minimax_algo
    code_combo
  end
end

# cb = CodeBreaker.new
# p cb.minimax_algo
