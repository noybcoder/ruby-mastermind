require_relative 'character'
require_relative 'errors'
# frozen_string_literal: true

class CodeBreaker < Character
  include CustomErrors

  @@codebreaker_count = 0
  def initialize
    @@codebreaker_count += 1
    handle_game_violations(CodeBreakerLimitViolation, @@codebreaker_count)
  end
end
