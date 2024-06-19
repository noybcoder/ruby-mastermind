# frozen_string_literal: true

require_relative 'codemaker'

# PlayerCodeBreaker class that represents a human codemaker in the Mastermind game.
class PlayerCodeMaker < CodeMaker
  # Public: Sets the secret code for the game.
  #
  # Returns an array of integers representing the secret code.
  def set_secret_code
    select_code { prompt } # Calls the select_code method from the Character class with a prompt block
  end

  private

  # Private: Prompts the player to enter the secret code.
  #
  # Prints the available colors and prompts the codemaker to enter the secret code.
  #
  # Returns a string representing the entered secret code.
  def prompt
    # Prompts the codemaker to enter 4 numbers from available colors
    puts "Codemaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    gets.chomp # Reads and returns the user's input
  end
end
