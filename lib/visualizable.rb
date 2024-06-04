# frozen_string_literal: true

module Visualizable
  def display_code_peg_colors
    {
      1 => "\e[38;2;255;0;0;1m O \e[0m", # red
      2 => "\e[38;2;255;165;0;1m O \e[0m", # orange
      3 => "\e[38;2;255;255;51;1m O \e[0m", # yellow
      4 => "\e[38;2;0;255;0;1m O \e[0m", # green
      5 => "\e[38;2;30;144;255;1m O \e[0m", # blue
      6 => "\e[38;2;186;85;211;1m O \e[0m" # purple
    }
  end

  def display_key_peg_colors
    {
      1 => "\e[38;2;0;0;0;1m O \e[0m", # black
      2 => "\e[38;2;255;255;255;1m O \e[0m" # white
    }
  end
end
