require 'colorize'
require 'colorized_string'

class Board

  class Peg
    attr_reader :code_pegs,  :key_pegs
    def initialize
      @code_pegs = %w[red green yellow blue magenta cyan]
      @key_pegs = %w[black white]
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

board = Board.new
board.code_pegs_tracker.each { |color| puts ColorizedString['O'].colorize(color.to_sym) }
