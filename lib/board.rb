require 'colorize'
require 'colorized_string'
require_relative 'visualizable'

class Board
  include Visualizable

  class Peg
    attr_reader :code_pegs,  :key_pegs
    def initialize
      @code_pegs = Array(1..6)
      @key_pegs = Array(1..2)
    end
  end

  private_constant :Peg
  @@board_count = 0

  attr_accessor :code_pegs_tracker, :key_pegs_tracker
  def initialize
    @code_pegs_tracker = Peg.new.code_pegs
    @key_pegs_tracker = {}
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
