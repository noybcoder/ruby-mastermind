# frozen_string_literal: true

require_relative 'visualizable'
require_relative 'errors'

# Board class that represents the game board in the Mastermind game.
class Board
  include CustomErrors # Includes the CustomErrors module for handling custom error classes
  include Visualizable # Includes the Visualizable module for visual display methods

  # Nested Peg class that represents pegs on the board.
  class Peg
    # Provides read-only access to code_pegs and key_pegs
    attr_reader :code_pegs, :key_pegs

    # Public: Initializes a new Peg instance.
    #
    # Returns a new Peg object.
    def initialize
      @code_pegs = Array(1..6) # Creates an array of code pegs with values from 1 to 6
      @key_pegs = Array(1..2) # Creates an array of key pegs with values from 1 to 2
    end
  end

  # Class-level accessor for the board count.
  class << self
    attr_accessor :board_count # Provides read-write access to the board_count class variable
  end

  private_constant :Peg # Makes the Peg class a private constant within the Board class
  @board_count = 0 # Initializes the board count to 0
  BOARD_LIMIT = 1 # Sets the limit for the number of boards to 1

  # Provides read-write access to code_pegs_tracker and key_pegs_tracker
  attr_accessor :code_pegs_tracker, :key_pegs_tracker
  attr_reader :secret_code # Provides read-only access to the secret_code

  # Public: Initializes a new Board instance.
  #
  # codemaker - The codemaker object responsible for setting the secret code.
  #
  # Returns a new Board object.
  def initialize(codemaker)
    @secret_code = codemaker.set_secret_code # Sets the secret code supplied by the codemaker
    @code_pegs_tracker = [] # Initializes an empty array to track code pegs
    @key_pegs_tracker = [] # Initializes an empty array to track key pegs
    self.class.board_count += 1 # Increments the board count

    # Handles violations of the board limit
    handle_game_violations(BoardLimitViolation, self.class.board_count, BOARD_LIMIT)
  end
end
