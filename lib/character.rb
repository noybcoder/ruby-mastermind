# frozen_string_literal: true

require_relative 'visualizable'

# Character class that represents either a codemaker or a codebreaker in the Mastermind game.
class Character
  include Visualizable

  # Public: Prompts the user to enter a code and ensures the code is valid.
  #
  # Returns a validated code entered by the user.
  def select_code
    loop do
      # If a block is given, it uses the block to get the code instead of prompting.
      code = block_given? ? yield : prompt
      return get_code(code) if valid_code?(code)

      puts 'Please only enter 4 integers between 1 and 6 with no spaces or symbols within.'
    end
  end

  private
  # Private: Prompts the user to enter a code.
  #
  # Returns a code that contains 4 numbers between 1 and 6 entered by the user.
  def prompt
    puts "Enter any 4 numbers from #{display_colors(delimiter: ', ')}:"
    gets.chomp
  end

  # Private: Checks if the given code is valid.
  #
  # Checks if the given code consists of exactly 4 digits, each between 1 and 6.
  def valid_code?(code)
    code.match?(/^[1-6]{4}$/)
  end

  # Private: Converts the valid code string into an array of integers.
  #
  # Returns an array of 4 integers which represents the code entered by the user.
  def get_code(code)
    code.chars.map(&:to_i)
  end
end
