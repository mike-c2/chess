# frozen_string_literal: true

require_relative '../colors/white'
require_relative 'control'

##
# Manages the white's turn
class WhiteControl < Control
  include White

  def play
    move_choice = player_move
    move_choice.move
  end
end
