# frozen_string_literal: true

require_relative '../colors/black'
require_relative 'control'

##
# Manages the black's turn
class BlackControl < Control
  include Black

  def play
    move_choice = player_move
    move_choice.move
  end
end
