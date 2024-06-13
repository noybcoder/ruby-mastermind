# frozen_string_literal: true

require_relative 'errors'
require_relative 'visualizable'
require_relative 'codebreaker'

class PlayerCodeBreaker < CodeBreaker
  include Visualizable
  include CustomErrors

  def make_guesses
    select_code { prompt }
  end

  def prompt
    puts "Codebreaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to crack the code:"
    gets.chomp
  end
end
