# frozen_string_literal: true

require_relative '../pawn'
require_relative '../../colors/white'

##
# Represents the White Pawn in Chess.
class WhitePawn < Pawn
  include White
end
