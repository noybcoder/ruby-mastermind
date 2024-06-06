# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require_relative 'visualizable'
require_relative 'codemaker'
require_relative 'codebreaker'

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

  attr_accessor :code_pegs_tracker, :key_pegs_tracker
  attr_reader :secret_code, :codemaker

  def initialize
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @code_pegs_tracker = Array.new(12) { Array.new(4) }
    @key_pegs_tracker = Array.new(12) { Array.new(4) }
    @secret_code = codemaker.select_secret_code
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
p board.secret_code
