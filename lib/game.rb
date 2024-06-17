# frozen_string_literal: true

require_relative 'board'
require_relative 'npccodemaker'
require_relative 'playercodebreaker'
require_relative 'npccodebreaker'
require_relative 'playercodemaker'

class Game
  attr_reader :board, :codebreaker, :codemaker

  ROUND_LIMIT = 11

  def initialize
    @character = select_character
    @codemaker = @character == 1 ? PlayerCodeMaker.new : NPCCodeMaker.new
    @codebreaker = @character == 1 ? NPCCodeBreaker.new : PlayerCodeBreaker.new
    @board = Board.new(codemaker)
  end

  def play
    round = 0
    loop do
      puts "Round #{round + 1}"
      update_code_pegs_tracker(round)
      update_key_pegs_tracker(round)
      board.display_board(round, board.code_pegs_tracker, board.key_pegs_tracker)
      if win?(round)
        display_win_message
        break
      elsif lose?(round)
        display_lose_message
        break
      end
      round += 1
    end
  end

  def update_code_pegs_tracker(round = nil)
    board.code_pegs_tracker << codebreaker.make_guesses(round)
  end

  def update_key_pegs_tracker(round)
    board.key_pegs_tracker << finalize_validated_guess(round)
    return unless codebreaker.instance_of?(NPCCodeBreaker)

    codebreaker.filter_possible_guesses(board.code_pegs_tracker[round], get_validated_guess(round))
  end

  private

  def select_character
    loop do
      puts 'Would you like to be the codemaker (Enter 1) or codebreaker (Enter 2)'
      character = gets.chomp
      return character.to_i if character.to_i.between?(1, 2)

      puts 'Please only enter 1 to play codemaker or 2 to play codebreaker.'
    end
  end

  def win?(round)
    board.key_pegs_tracker[round].all?(0)
  end

  def lose?(round)
    round.eql?(ROUND_LIMIT) && !win?(round)
  end

  def display_win_message
    puts "Congratulations, codebreaker! You have cracked the code!\n\n"
  end

  def reveal_secret_code
    board.display_secret_code(board.secret_code)
  end

  def display_lose_message
    puts "Oops, the secret code is #{reveal_secret_code}. Better luck next time!\n\n"
  end

  def finalize_validated_guess(round)
    guess = get_validated_guess(round)
    validated_guess = guess.flat_map.with_index { |count, index| [index] * count }
    validated_guess.fill(nil, validated_guess.size...board.secret_code.size)
  end

  def get_validated_guess(round)
    codemaker.validate_guess(board.code_pegs_tracker[round], board.secret_code)
  end
end

game = Game.new
puts game.play
