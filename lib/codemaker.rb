# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'
require_relative 'visualizable'

class CodeMaker < Character
  include Visualizable
  include CustomErrors

  class << self
    attr_accessor :codemaker_count
  end

  CODEMAKER_LIMIT = 1
  @codemaker_count = 0

  def initialize
    super
    self.class.codemaker_count += 1
    handle_game_violations(CodeMakerLimitViolation, self.class.codemaker_count, CODEMAKER_LIMIT)
  end

  def set_secret_code
    select_code { randomize }
  end

  def randomize
    puts "Codemaker, enter 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    puts 'The secret code is created. Time to guess!'
    4.times.map { rand(1..6) }.join('')
  end

  def validate_guess(guesses, secret_code)
    guesses.map.each_with_index do |guess, index|
      if guess == secret_code[index]
        1
      elsif guesses.count(guess) <= secret_code.count(guess)
        0
      else
        -1
      end
    end
  end
end
