# frozen_string_literal: true

# Visualizable module provides methods for setting peg colors and displaying the board.
module Visualizable
  # Public: Sets the colors for code pegs using ANSI escape codes.
  #
  # peg - The peg character to be colored (default: "\u25cf").
  #
  # Returns a hash mapping peg numbers to their respective colored peg characters.
  def set_code_peg_colors(peg = "\u25cf")
    {
      1 => "\e[38;2;255;0;0;1m#{peg}\e[0m", # red
      2 => "\e[38;2;255;165;0;1m#{peg}\e[0m", # orange
      3 => "\e[38;2;255;255;51;1m#{peg}\e[0m", # yellow
      4 => "\e[38;2;0;255;0;1m#{peg}\e[0m", # green
      5 => "\e[38;2;30;144;255;1m#{peg}\e[0m", # blue
      6 => "\e[38;2;186;85;211;1m#{peg}\e[0m" # purple
    }
  end

  # Public: Sets the colors for key pegs using ANSI escape codes.
  #
  # peg - The peg character to be colored (default: "\u25cf").
  #
  # Returns a hash mapping key peg values to their respective colored peg characters.
  def set_key_peg_colors(peg = "\u25cf")
    {
      0 => "\e[38;2;0;0;0;1m#{peg}\e[0m", # black
      1 => "\e[38;2;255;255;255;1m#{peg}\e[0m", # white
      nil => "\e[38;2;0;0;0;1m \e[0m" # empty space for nil value
    }
  end

  # Public: Displays the colored pegs.
  #
  # args - A hash containing options for displaying colors:
  #        :peg_numbers - An array of peg numbers to display (default: Array(1..6)).
  #        :delimiter - A string to separate the colored pegs (default: '  ').
  #        :code_set - The method to use for setting colors (default: :set_code_peg_colors).
  #
  # Returns a string of concatenated colored pegs.
  def display_colors(args)
    peg_numbers = args.fetch(:peg_numbers, Array(1..6))
    delimiter = args.fetch(:delimiter, '  ')
    code_set = args.fetch(:code_set, :set_code_peg_colors)

    peg_numbers.map do |num|
      send(code_set, args.fetch(:peg, num))[num]
    end.join(delimiter)
  end

  # Public: Displays the code pegs for a given round.
  #
  # code_pegs_tracker - An array tracking the code pegs for each round.
  # round - The current round number.
  #
  # Returns a string of colored code pegs for the given round.
  def display_code_pegs(code_pegs_tracker, round)
    display_colors(peg_numbers: code_pegs_tracker[round], peg: "\u25cf")
  end

  # Public: Displays the key pegs for a given round.
  #
  # key_pegs_tracker - An array tracking the key pegs for each round.
  # round - The current round number.
  #
  # Returns a string of colored key pegs for the given round.
  def display_key_pegs(key_pegs_tracker, round)
    display_colors(peg_numbers: key_pegs_tracker[round], code_set: :set_key_peg_colors, peg: "\u25cf")
  end

  # Public: Displays the secret code.
  #
  # secret_code - An array representing the secret code.
  #
  # Returns a string of colored pegs representing the secret code.
  def display_secret_code(secret_code)
    display_colors(peg_numbers: secret_code, peg: "\u25cf")
  end

  # Public: Displays the headers for the game board.
  #
  # Returns nothing.
  def display_board_headers
    puts "\n"
    puts '--------------------------------------------------------------------'
    puts '| Round |   Guess    |    Hint    |             Remark             |'
    puts '--------------------------------------------------------------------'
  end

  # Public: Displays the summary of rounds including guesses and hints.
  #
  # round - The current round number.
  # code_pegs_tracker - An array tracking the code pegs for each round.
  # key_pegs_tracker - An array tracking the key pegs for each round.
  #
  # Returns nothing.
  def display_round_summary(round, code_pegs_tracker, key_pegs_tracker)
    (round + 1).times do |idx|
      print idx + 1 < 10 ? "|   #{idx + 1}   | " : "|  #{idx + 1}   | "
      print "#{display_code_pegs(code_pegs_tracker, idx)} | "
      print "#{display_key_pegs(key_pegs_tracker, idx)} | "
      print "Matches => exact: #{key_pegs_tracker[idx].count(0)} | "
      puts "color: #{key_pegs_tracker[idx].count(1)} |"
    end
    puts "--------------------------------------------------------------------\n"
  end

  # Public: Displays the entire game board including headers and round summaries.
  #
  # round - The current round number.
  # code_pegs_tracker - An array tracking the code pegs for each round.
  # key_pegs_tracker - An array tracking the key pegs for each round.
  #
  # Returns nothing.
  def display_board(round, code_pegs_tracker, key_pegs_tracker)
    display_board_headers
    display_round_summary(round, code_pegs_tracker, key_pegs_tracker)
  end
end
