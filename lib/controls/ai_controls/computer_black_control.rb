# frozen_string_literal: true

require_relative '../../colors/black'
require_relative 'computer_control'

##
# Manages the black's turn, as an AI
class ComputerBlackControl < ComputerControl
  include Black
end
