# frozen_string_literal: true

require_relative 'character'
require_relative 'errors'

class CodeMaker < Character
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
end
