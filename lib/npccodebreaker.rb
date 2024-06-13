# frozen_string_literal: true

require_relative 'codebreaker'

class NPCCodeBreaker < CodeBreaker

  attr_accessor :guess_combos
  def initialize
    super
    @guess_combos = Array(1..6).repeated_permutation(4).to_a
  end
end
