# frozen_string_literal: true

# CustomErrors module defines custom error classes for the Mastermind game.
module CustomErrors
  # PlayerLimitViolation class represents an error when the number of players exceeds the limit.
  class CodeMakerLimitViolation < StandardError
    # Public: Initializes a new PlayerLimitViolation instance.
    #
    # msg - The message to be displayed for the error (default: 'Mastermind only allows up to 2 players.').
    # exception_type - The type of exception (default: 'custom').
    #
    # Returns a new PlayerLimitViolation object.
    def initialize(msg = 'Mastermind only allows 1 codemaker.', exception_type = 'custom')
      @exception_type = exception_type
      super(msg)
    end
  end

  # PlayerLimitViolation class represents an error when the number of players exceeds the limit.
  class CodeBreakerLimitViolation < StandardError
    # Public: Initializes a new PlayerLimitViolation instance.
    #
    # msg - The message to be displayed for the error (default: 'Mastermind only allows up to 2 players.').
    # exception_type - The type of exception (default: 'custom').
    #
    # Returns a new PlayerLimitViolation object.
    def initialize(msg = 'Mastermind only allows 1 codebreaker.', exception_type = 'custom')
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

  def handle_game_violations(error, class_variable, limit)
    # Raise error if more than one board instance is created
    raise error if class_variable > limit
  rescue error => e
    puts e.message # Display the error message
    exit # Terminate the program
  end
end
