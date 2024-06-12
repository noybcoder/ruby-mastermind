# frozen_string_literal: true

require_relative 'codemaker'
require_relative 'errors'
require_relative 'visualizable'

class NPCCodeMaker < CodeMaker
  include Visualizable
  include CustomErrors

  def set_secret_code
    select_code { randomize }
  end

  def validate_guess(guesses, secret_code)
    guesses.map.each_with_index do |guess, index|
      if guess == secret_code[index]
        1
      elsif guesses.count(guess) <= secret_code.count(guess)
        0
      else
        -1
      end
    end
  end

  private

  def randomize
    puts "Codemaker, enter 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    puts 'The secret code is created. Time to guess!'
    4.times.map { rand(1..6) }.join('')
  end
end


ncm = NPCCodeMaker.new
p ncm.validate_guess([4, 4, 1, 4], [4, 1, 4, 3])
# guess: 4414 secret_code: 4143
# first condition [1, nil, nil, nil]
# second condition [1, nil, 0, nil]
# third condition [1, -1, 0, -1]
# should be [1, 0, 0, -1]
