# frozen_string_literal: true

require_relative 'codebreaker'

class NPCCodeBreaker < CodeBreaker

  attr_accessor :possible_guesses, :matches
  def initialize
    super
    @possible_guesses = Array(1..6).repeated_permutation(4).to_a
    @matches = Array.new(2)
  end

  def make_guesses(round)
    select_code {prompt(round)}
  end

  def prompt(round)
    puts "Codebreaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to crack the code:"
    # set_strategy(round, key_pegs_tracker)
    set_strategy(round)
  end

  def set_strategy(round, key_pegs_tracker=nil)
    guess = round == 0? '1122': randomize
    # filter_possible_guesses(guess, key_pegs_tracker[round])
  end

  def randomize
    possible_guesses.sample.join
  end

  def filter_possible_guesses(guess, feedback)
    possible_guesses.select { |possible_guess| get_feedback(guess, possible_guess) == feedback}
  end

  def get_feedback(guesses, codes)
    exact_matches = guesses.zip(codes).count { |guess, code| guess == code }
    color_matches = guesses.uniq.sum { |peg| [guesses.count(peg), codes.count(peg)].min } - exact_matches
    [exact_matches, color_matches]
  end

end

# ncb = NPCCodeBreaker.new
# first_guess = '1122'
# feedback = ncb.get_feedback(first_guess, [4,2,4,3])
# p feedback
