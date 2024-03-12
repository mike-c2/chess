# frozen_string_literal: true

require_relative '../../colors/white'
require_relative 'computer_control'

##
# Manages the white's turn, as an AI
class ComputerWhiteControl < ComputerControl
  include White
end
