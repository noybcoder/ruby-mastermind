require_relative 'character'
# frozen_string_literal: true

class CodeMaker < Character
  def select_secret_code
    super.select_code
  end
end

cm = CodeMaker.new
p cm.select_secret_code
