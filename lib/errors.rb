# frozen_string_literal: true

# CustomErrors module defines custom error classes for the Mastermind game.
module CustomErrors
  # PlayerLimitViolation class represents an error when the number of players exceeds the limit.
  class PlayerLimitViolation < StandardError
    # Public: Initializes a new PlayerLimitViolation instance.
    #
    # msg - The message to be displayed for the error (default: 'Mastermind only allows up to 2 players.').
    # exception_type - The type of exception (default: 'custom').
    #
    # Returns a new PlayerLimitViolation object.
    def initialize(msg = 'Mastermind only allows up to 2 players.', exception_type = 'custom')
      @exception_type = exception_type
      super(msg)
    end
  end

  # BoardLimitViolation class represents an error when attempting to create more than one game board.
  class BoardLimitViolation < StandardError
    # Public: Initializes a new BoardLimitViolation instance.
    #
    # msg - The message to be displayed for the error (default: 'Only 1 board is allowed in Mastermind.').
    # exception_type - The type of exception (default: 'custom').
    #
    # Returns a new BoardLimitViolation object.
    def initialize(msg = 'Only 1 board is allowed in Mastermind.', exception_type = 'custom')
      @exception_type = exception_type
      super(msg)
    end
  end
end
