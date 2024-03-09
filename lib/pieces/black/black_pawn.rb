# frozen_string_literal: true

require_relative '../pawn'
require_relative '../../colors/black'

##
# Represents the Black Pawn in Chess.
class BlackPawn < Pawn
  include Black
end
