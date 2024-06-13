# frozen_string_literal: true

module Visualizable
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

  def set_key_peg_colors(peg = "\u25cf")
    {
      1 => "\e[38;2;0;0;0;1m#{peg}\e[0m", # black
      0 => "\e[38;2;255;255;255;1m#{peg}\e[0m", # white
      nil => "\e[38;2;0;0;0;1m \e[0m"
    }
  end

  def display_colors(args)
    peg_numbers = args.fetch(:peg_numbers, Array(1..6))
    delimiter = args.fetch(:delimiter, '  ')
    code_set = args.fetch(:code_set, :set_code_peg_colors)

    peg_numbers.map do |num|
      send(code_set, args.fetch(:peg, num))[num]
    end.join(delimiter)
  end

  def display_code_pegs(code_pegs_tracker, round)
    display_colors(peg_numbers: code_pegs_tracker[round], peg: "\u25cf")
  end

  def display_key_pegs(key_pegs_tracker, round)
    display_colors(peg_numbers: key_pegs_tracker[round], code_set: :set_key_peg_colors, peg: "\u25cf")
  end

  def display_secret_code(secret_code)
    display_colors(peg_numbers: secret_code, peg: "\u25cf")
  end

  def display_board_headers
    puts "\n"
    puts '--------------------------------------------------------------------'
    puts '| Round |   Guess    |    Hint    |             Remark             |'
    puts '--------------------------------------------------------------------'
  end

  def display_round_summary(round, code_pegs_tracker, key_pegs_tracker)
    (round + 1).times do |idx|
      print idx + 1 < 10 ? "|   #{idx + 1}   | " : "|  #{idx + 1}   | "
      print "#{display_code_pegs(code_pegs_tracker, idx)} | "
      print "#{display_key_pegs(key_pegs_tracker, idx)} | "
      print "Matches => exact: #{key_pegs_tracker[idx].count(1)} | "
      puts "color: #{key_pegs_tracker[idx].count(0)} |"
    end
    puts "--------------------------------------------------------------------\n"
  end

  def display_board(round, code_pegs_tracker, key_pegs_tracker)
    display_board_headers
    display_round_summary(round, code_pegs_tracker, key_pegs_tracker)
  end
end
