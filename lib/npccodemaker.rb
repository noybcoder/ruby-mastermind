# frozen_string_literal: true

require_relative 'codemaker'

# NPCCodeMaker class that represents a computer codemaker in the Mastermind game.
class NPCCodeMaker < CodeMaker
  # Public: Sets the secret code for the game.
  #
  # Returns an array of integers representing the secret code.
  def set_secret_code
    select_code { randomize } # Calls the select_code method from Character class with a randomize block
  end

  private

  # Private: Generates a random secret code.
  #
  # Prints the available colors and indicates that the secret code has been created.
  #
  # Returns a string representing the randomly generated secret code.
  def randomize
    # Prompts to enter 4 numbers
    puts "Codemaker, enter 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    puts 'The secret code is created. Time to guess!' # Indicates that the secret code has been created
    # Generates a random 4-digit code where each digit is between 1 and 6
    4.times.map { rand(1..6) }.join('')
  end
end
