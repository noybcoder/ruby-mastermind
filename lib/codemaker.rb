# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'

class CodeMaker < Character
  include CustomErrors

  CODEMAKER_LIMIT = 1
  @codemaker_count = 0

  class << self
    attr_accessor :codemaker_count
  end

  def initialize
    super
    self.class.codemaker_count ||= 0
    self.class.codemaker_count += 1
    handle_game_violations(CodeMakerLimitViolation, self.class.codemaker_count, CODEMAKER_LIMIT)
  end

  def validate_guess(guesses, secret_code)
    secret_code_counts = secret_code.tally

    guesses.map.each_with_index do |guess, index|
      if guess == secret_code[index]
        secret_code_counts[guess] -= 1
        1
      elsif (secret_code_counts[guess] || 0) > 0
        secret_code_counts[guess] -= 1
        0
      end
    end
  end
end
