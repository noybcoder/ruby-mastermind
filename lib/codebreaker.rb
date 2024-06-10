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

  def initialize
    super
    self.class.codebreaker_count += 1
    handle_game_violations(CodeBreakerLimitViolation, self.class.codebreaker_count, CODEBREAKER_LIMIT)
  end

  def make_guesses
    select_code { prompt }
  end

  def prompt
    puts "Codebreaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to crack the code:"
    gets.chomp
  end
end

# cb = CodeBreaker.new
# puts cb.make_guesses
