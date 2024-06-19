# frozen_string_literal: true

require_relative 'board'
require_relative 'npccodemaker'
require_relative 'playercodebreaker'
require_relative 'npccodebreaker'
require_relative 'playercodemaker'

# Game class that represents the overall gameplay in the Mastermind game.
class Game
  # Provides read-only access to board, codebreaker, codemaker, and rounds
  attr_reader :board, :codebreaker, :codemaker, :rounds

  # Public: Initializes a new Game instance.
  #
  # rounds - The number of rounds to play (default is 11).
  #
  # Returns a new Game object.
  def initialize(rounds=11)
    @character = select_character # Prompts the user to select a character
    # Sets the codemaker based on user selection
    @codemaker = @character == 1 ? PlayerCodeMaker.new : NPCCodeMaker.new
    # Sets the codebreaker based on user selection
    @codebreaker = @character == 1 ? NPCCodeBreaker.new : PlayerCodeBreaker.new
    @board = Board.new(codemaker) # Initializes a new board with the codemaker
    @rounds = rounds # Sets the number of rounds
  end

  # Public: Starts the gameplay loop.
  #
  # Returns nothing.
  def play
    round = 0
    loop do
      puts "\nRound #{round + 1}" # Displays the current round
      update_code_pegs_tracker(round) # Updates the code pegs tracker for the current round
      update_key_pegs_tracker(round) # Updates the key pegs tracker for the current round
      # Displays the game board
      board.display_board(round, board.code_pegs_tracker, board.key_pegs_tracker)
      if win?(round) # Checks if the codebreaker (codemaker) wins (loses) the game
        display_win_message
        break
      elsif lose?(round) # Checks if the codebreaker (codemaker) loses (wins) the game
        display_lose_message
        break
      end
      round += 1
    end
  end

  private

  # Private: Updates the code pegs tracker with guesses for the current round.
  #
  # round - The current round number.
  #
  # Returns nothing.
  def update_code_pegs_tracker(round = nil)
    # Adds guesses to the code pegs tracker
    board.code_pegs_tracker << codebreaker.make_guesses(round)
  end

  # Private: Updates the key pegs tracker with validated guesses for the current round.
  #
  # round - The current round number.
  #
  # Returns nothing.
  def update_key_pegs_tracker(round)
    # Adds validated guesses to the key pegs tracker
    board.key_pegs_tracker << finalize_validated_guess(round)

    # Filters possible guesses for NPC codebreaker based on feedback
    return unless codebreaker.instance_of?(NPCCodeBreaker)
    codebreaker.filter_possible_guesses(board.code_pegs_tracker[round], get_validated_guess(round))
  end

  # Private: Prompts the user to select the character role (codemaker or codebreaker).
  #
  # Returns the selected character role as an integer.
  def select_character
    loop do
      # Prompt for character selection
      puts 'Would you like to be the codemaker (Enter 1) or codebreaker (Enter 2)'
      character = gets.chomp
      return character.to_i if character.to_i.between?(1, 2) # Vaiidates the input

      # Error message for invalid input
      puts 'Please only enter 1 to play codemaker or 2 to play codebreaker.'
    end
  end

  # Private: Checks if the codebreaker wins the game.
  #
  # round - The current round number.
  #
  # Returns true if the codebreaker wins, false otherwise.
  def win?(round)
    board.key_pegs_tracker[round].all?(0) # Checks if all key pegs are 0
  end

  # Private: Checks if the codebreaker loses the game.
  #
  # round - The current round number.
  #
  # Returns true if the codebreaker loses, false otherwise.
  def lose?(round)
    # Checks if all rounds are over and the win condition has not been met
    round.eql?(rounds) && !win?(round)
  end

  # Private: Displays the message when the codebreaker wins.
  #
  # Returns nothing.
  def display_win_message
    puts "Congratulations, codebreaker! You have cracked the code!\n\n"
  end

  # Private: Displays the message when the codebreaker loses.
  #
  # Returns nothing.
  def display_lose_message
    # Displays the message and reveals the secret_code when the codebreaker loses
    puts "Oops, the secret code is #{reveal_secret_code}. Better luck next time!\n\n"
  end

  # Private: Reveals the secret code.
  #
  # Returns the secret code as a string.
  def reveal_secret_code
    board.display_secret_code(board.secret_code)
  end

  # Private: Finalizes the validated guess for the current round.
  #
  # round - The current round number.
  #
  # Returns an array representing the validated guess.
  def finalize_validated_guess(round)
    guess = get_validated_guess(round) # Gets the validated guess
    # Formats the validated guess
    validated_guess = guess.flat_map.with_index { |count, index| [index] * count }
    # Fills remaining slots with nil
    validated_guess.fill(nil, validated_guess.size...board.secret_code.size)
  end

  # Private: Gets the validated guess for the current round.
  #
  # round - The current round number.
  #
  # Returns an array representing the validated guess.
  def get_validated_guess(round)
    # Validates the guess with the codemaker
    codemaker.validate_guess(board.code_pegs_tracker[round], board.secret_code)
  end
end
