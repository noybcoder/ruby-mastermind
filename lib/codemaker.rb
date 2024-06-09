# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'

class CodeMaker < Character
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

  def randomize
    rand(1..6)
  end

  def validate_guess(guesses, secret_code)
    guesses.map.each_with_index do |guess, index|
      if guess == secret_code[index]
        1
      elsif guesses.count(guess) <= secret_code.count(guess)
        0
      else
        nil
      end
    end
  end
end

cm = CodeMaker.new
puts cm.randomize
