# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'

# CodeMaker class that represents the codemaker in the Mastermind game.
class CodeMaker < Character
  include CustomErrors # Includes the custom error handling module

  CODEMAKER_LIMIT = 1 # Set the maximum limit of codemakers
  @codemaker_count = 0 # Set the codemaker count to 0

  # Class-level constant to set the maximum limit of codemakers
  class << self
    attr_accessor :codemaker_count
  end

  # Public: Initializes a new CodeMaker instance.
  #
  # Returns a new CodeMaker object.
  def initialize
    super # Calls the parent class (Character) initializer
    self.class.codemaker_count ||= 0 # Ensures codemaker count is not nil
    self.class.codemaker_count += 1 # Increments the codemaker count
    # Checks if the number of codemakers exceeds the limit and handles violations
    handle_game_violations(CodeMakerLimitViolation, self.class.codemaker_count, CODEMAKER_LIMIT)
  end

  # Public: Validates the guess against the secret code
  #
  # guesses - Array of integers representing the player's guess
  # codes - Array of integers representing the secret code
  #
  # Returns an array with two elements: the number of exact matches and the number of color matches
  def validate_guess(guesses, codes)
    # Counts the number of exact matches (correct color in the correct position)
    exact_matches = guesses.zip(codes).count { |guess, code| guess == code }
    # Counts the number of exact matches (correct color in the correct position)
    color_matches = guesses.uniq.sum { |peg| [guesses.count(peg), codes.count(peg)].min } - exact_matches
    [exact_matches, color_matches]
  end
end
