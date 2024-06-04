# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require_relative 'visualizable'

class Board
  include Visualizable

  class Peg
    attr_reader :code_pegs, :key_pegs

    def initialize
      @code_pegs = Array(1..6)
      @key_pegs = Array(1..2)
    end
  end

  private_constant :Peg
  @@board_count = 0

  attr_accessor :code_pegs_tracker, :key_pegs_tracker, :secret_code

  def initialize
    @code_pegs_tracker = Array.new(12) { Array.new(4) }
    @key_pegs_tracker = Array.new(12) { Array.new(4) }
    @secret_code = Array.new(4)
    @@board_count += 1

    begin
      # Raise error if more than one board instance is created
      raise CustomErrors::BoardLimitViolation if @@board_count > 1
    rescue CustomErrors::BoardLimitViolation => e
      puts e.message # Display the error message
      exit # Terminate the program
    end
  end
end

board = Board.new

# board.secret_code[0] = 'Preston'
p board.key_pegs_tracker
