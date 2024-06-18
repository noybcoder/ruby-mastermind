# frozen_string_literal: true

require_relative 'codemaker'
require_relative 'visualizable'

# PlayerCodeBreaker class that represents a human codemaker in the Mastermind game.
class PlayerCodeMaker < CodeMaker
  include Visualizable # Includes the visualizable module for color display methods

  def set_secret_code
    select_code { prompt }
  end

  private

  def prompt
    puts "Codemaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    gets.chomp
  end
end
