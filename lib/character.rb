# frozen_string_literal: true

require_relative 'visualizable'

class Character
  include Visualizable

  def select_code
    loop do
      code = block_given? ? yield : prompt
      return get_code(code) if valid_code?(code)

      puts 'Please only enter 4 integers between 1 and 6 with no spaces or symbols within.'
    end
  end

  private

  def prompt
    puts "Enter any 4 numbers from #{display_colors(delimiter: ', ')}:"
    gets.chomp
  end

  def valid_code?(code)
    code.match?(/^[1-6]{4}$/)
  end

  def get_code(code)
    code.chars.map(&:to_i)
  end
end
