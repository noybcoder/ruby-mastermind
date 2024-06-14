# frozen_string_literal: true

require_relative 'codemaker'
require_relative 'visualizable'

class PlayerCodeMaker < CodeMaker
  include Visualizable

  def set_secret_code
    select_code { prompt }
  end

  private

  def prompt
    puts "Codemaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    gets.chomp
  end
end
