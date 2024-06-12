# frozen_string_literal: true

class Mastermind
  COLORS = Array(1..6)
  CODE_LENGTH = 4

  attr_accessor :secret_code, :possible_guesses

  def initialize
    @secret_code = Array.new(CODE_LENGTH) { COLORS.sample }
    @possible_guesses = COLORS.repeated_permutation(CODE_LENGTH).to_a
  end

  def play
    puts 'Welcome to Mastermind!'
    puts "Try to guess the secret code. The possible colors are: #{COLORS.join(', ')}"
    puts 'The computer has 12 turns to guess the correct code.'

    12.times do |turn|
      guess = computer_guess
      feedback = get_feedback(guess, @secret_code)
      puts "Turn #{turn + 1}: Computer guessed #{guess.join(', ')} - Feedback: #{feedback}"

      if feedback == [CODE_LENGTH, 0]
        puts "Computer cracked the code in #{turn + 1} turns!"
        return
      end

      filter_possible_guesses(guess, feedback)
    end

    puts "Computer failed to guess the code. The secret code was #{@secret_code.join(', ')}"
  end

  # private

  def computer_guess
    @possible_guesses.sample
  end

  def filter_possible_guesses(guess, feedback)
    @possible_guesses.select! do |possible_guess|
      get_feedback(guess, possible_guess) == feedback
    end
  end

  def get_feedback(guess, code)
    exact_matches = guess.zip(code).count { |g, c| g == c }
    color_matches = guess.uniq.sum { |color| [guess.count(color), code.count(color)].min } - exact_matches
    [exact_matches, color_matches]
  end
end

game = Mastermind.new
# exact_matches = [1, 1, 2, 2].zip([1, 2, 1, 2]).count { |g, c| g == c }
# color_matches = [1, 1, 2, 2].uniq.sum { |color| [[1, 1, 2, 2].count(color), [1, 2, 1, 2].count(color)].min } - exact_matches
# p [exact_matches, color_matches]
game.play
