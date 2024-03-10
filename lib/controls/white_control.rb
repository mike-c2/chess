# frozen_string_literal: true

require_relative '../colors/white'
require_relative 'control'

##
# Manages the white's turn
class WhiteControl < Control
  include White
end
