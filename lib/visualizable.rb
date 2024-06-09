# frozen_string_literal: true

module Visualizable
  def set_code_peg_colors(peg = "\u2b24")
    {
      1 => "\e[38;2;255;0;0;1m#{peg}\e[0m", # red
      2 => "\e[38;2;255;165;0;1m#{peg}\e[0m", # orange
      3 => "\e[38;2;255;255;51;1m#{peg}\e[0m", # yellow
      4 => "\e[38;2;0;255;0;1m#{peg}\e[0m", # green
      5 => "\e[38;2;30;144;255;1m#{peg}\e[0m", # blue
      6 => "\e[38;2;186;85;211;1m#{peg}\e[0m" # purple
    }
  end

  def set_key_peg_colors(peg = "\u2b24")
    {
      exact_match: "\e[38;2;0;0;0;1m#{peg}\e[0m", # black
      color_match: "\e[38;2;255;255;255;1m#{peg}\e[0m" # white
    }
  end

  def display_colors(args)
    # args = defaults.merge(args)
    # peg_numbers = args[:peg_numbers]
    # delimiter = args[:delimiter]

    peg_numbers = args.fetch(:peg_numbers, Array(1..6))
    delimiter = args.fetch(:delimiter, '')

    peg_numbers.map { |num| set_code_peg_colors(num)[num] }.join(delimiter)
  end

  # def defaults
  #   {:peg_numbers => Array(1..6), :peg => "\u2b24", :delimiter => ", "}
  # end
end
