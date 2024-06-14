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

  def validate_guess(guesses, codes)
    exact_matches = guesses.zip(codes).count { |guess, code| guess == code }
    color_matches = guesses.uniq.sum { |peg| [guesses.count(peg), codes.count(peg)].min } - exact_matches
    [exact_matches, color_matches]
  end
end
