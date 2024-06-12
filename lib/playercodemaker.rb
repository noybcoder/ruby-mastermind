# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'

class PlayerCodeMaker < Character
  include CustomErrors

  class << self
    attr_accessor :codemaker_count
  end

  CODEMAKER_LIMIT = 1
  @codemaker_count = 0

  def initialize
    super
    self.class.codemaker_count += 1
    handle_game_violations(CodeMakerLimitViolation, self.class.codemaker_count, CODEMAKER_LIMIT)
  end

  def set_secret_code
    select_code { prompt }
  end

  private

  def prompt
    puts "Codemaker, enter any 4 numbers from #{display_colors(delimiter: ', ')} to create the secret code:"
    gets.chomp
    puts 'The secret code is created. Time to guess!'
  end
end
