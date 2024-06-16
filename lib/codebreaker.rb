# frozen_string_literal: true

require_relative 'errors'
require_relative 'character'

class CodeBreaker < Character
  include CustomErrors

  class << self
    attr_accessor :codebreaker_count
  end

  CODEBREAKER_LIMIT = 1
  @codebreaker_count = 0

  def initialize
    super
    self.class.codebreaker_count ||= 0
    self.class.codebreaker_count += 1
    handle_game_violations(CodeBreakerLimitViolation, self.class.codebreaker_count, CODEBREAKER_LIMIT)
  end
end
