require_relative 'character'
require_relative 'errors'
# frozen_string_literal: true

class CodeMaker < Character
  include CustomErrors

  @@codemaker_count = 0
  def initialize
    @@codemaker_count += 1
    handle_game_violations(CodeMakerLimitViolation, @@codemaker_count)
  end
end
