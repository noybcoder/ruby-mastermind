# frozen_string_literal: true

require_relative 'codebreaker'
require_relative 'visualizable'

# PlayerCodeBreaker class that represents a human codebreaker in the Mastermind game.
class PlayerCodeBreaker < CodeBreaker
  include Visualizable  # Includes the visualizable module for color display methods

  # Public: Prompts the player to make guesses for the code.
  #
  # round - The current round of the game (default: nil).
  #
  # Returns an array of integers representing the player's guess.
  def make_guesses(round = nil)
    select_code { prompt } # Calls the select_code method from Character class with a prompt block
  end

  # Public: Prompts the player to enter their guess for the code.
  #
  # Returns a string representing the player's input.
  def prompt
    # Prompts the player to enter a guess
    puts "Codebreaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to crack the code:"
    gets.chomp # Gets the player's input and removes the trailing newline character
  end
end
