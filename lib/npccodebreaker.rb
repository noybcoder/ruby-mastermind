# frozen_string_literal: true

require_relative 'codebreaker'

# NPCCodeBreaker class that represents a computer codebreaker in the Mastermind game.
class NPCCodeBreaker < CodeBreaker
  attr_accessor :possible_guesses # Allows reading and writing of the possible_guesses attribute

  # Public: Initializes a new NPCCodeBreaker instance.
  #
  # Returns a new NPCCodeBreaker object.
  def initialize
    super # Calls the initialize method of the parent class (CodeBreaker)
    # Generates all possible 4-number combinations from 1 to 6
    @possible_guesses = Array(1..6).repeated_permutation(4).to_a
  end

  # Public: Makes guesses to crack the code.
  #
  # round - The current round number.
  #
  # Returns an array of integers representing the guessed code.
  def make_guesses(round)
    # Calls the select_code method from the Character class with a prompt block
    select_code { prompt(round) }
  end

  # Public: Filters the possible guesses based on the feedback from the latest guess.
  #
  # guess - The guessed code.
  # feedback - The feedback for the guessed code.
  #
  # Returns nothing.
  def filter_possible_guesses(guess, feedback)
    possible_guesses.select! { |possible_guess| get_feedback(guess, possible_guess) == feedback }
  end

  private

  # Private: Prompts the NPC to enter a code.
  #
  # round - The current round number.
  #
  # Returns a string representing the guessed code.
  def prompt(round)
    # Prompts to enter 4 numbers from available colors
    puts "Codebreaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to crack the code:"
    # Returns '1122' for the first round, otherwise returns a random guess
    round.zero? ? '1122' : randomize
  end

  # Private: Updates the feedback tracker with the feedback from the latest guess.
  #
  # guesses - The guessed code.
  # codes - The secret code.
  #
  # Returns nothing.
  def update_feedback_tracker(guesses, codes)
    # Adds the feedback for the latest guess to the feedback tracker
    feedback_tracker << get_feedback(guesses, codes)
  end

  # Private: Randomizes the possible guesses.
  #
  # Returns a string representing a random guess.
  def randomize
    possible_guesses.sample.join # Returns a random guess from the possible guesses
  end

  # Public: Gets feedback for the guessed code.
  #
  # guesses - The guessed code.
  # codes - The secret code.
  #
  # Returns an array with the counts of exact matches and color matches.
  def get_feedback(guesses, codes)
    # Counts the number of exact matches
    exact_matches = guesses.zip(codes).count { |guess, code| guess == code }
    # Counts the number of color matches
    color_matches = guesses.uniq.sum { |peg| [guesses.count(peg), codes.count(peg)].min } - exact_matches
    [exact_matches, color_matches] # Returns the feedback as an array of exact matches and color matches
  end
end
