# frozen_string_literal: true

require_relative 'visualizable'

class CodeMaker
  include Visualizable

  def select_secret_code
    loop
      puts "Enter any 4 numbers from #{display_colors(delimiter: ", ")}"
      secret_code = gets.chomp

      unless secret_code.match?(/^[1-6]{4}$/)
        puts 'Please only enter integers between 1 and 6 with no spaces within.'
      else
        p secret_code
      end
    end
  end

cm = CodeMaker.new
cm.select_secret_code
