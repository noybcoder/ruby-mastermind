require_relative 'character'
# frozen_string_literal: true

class CodeBreaker < Character
  def guess_secret_code
    super.select_code
  end
end

cb = CodeBreaker.new
cb.guess_secret_code
