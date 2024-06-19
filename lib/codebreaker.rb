# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'

# CodeMaker class that represents the codebreaker in the Mastermind game.
class CodeBreaker < Character
  include CustomErrors # Includes the custom error handling module

  CODEBREAKER_LIMIT = 1 # Set the maximum limit of codebreakers
  @codebreaker_count = 0 # Set the codebreaker coun to 0

  # Class-level constant to set the maximum limit of codebreakers
  class << self
    attr_accessor :codebreaker_count
  end

  # Public: Initializes a new CodeBreaker instance.
  #
  # Returns a new CodeBreaker object.
  def initialize
    super # Calls the parent class (Character) initializer
    self.class.codebreaker_count ||= 0 # Ensures codebreaker count is not nil
    self.class.codebreaker_count += 1 # Increments the codebreaker count
    # Checks if the number of codebreakers exceeds the limit and handles violations
    handle_game_violations(CodeBreakerLimitViolation, self.class.codebreaker_count, CODEBREAKER_LIMIT)
  end
end
