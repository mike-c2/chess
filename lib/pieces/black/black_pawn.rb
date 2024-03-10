# frozen_string_literal: true

require_relative '../pawn'
require_relative '../../colors/black'

##
# Represents the Black Pawn in Chess.
class BlackPawn < Pawn
  include Black

  def initialize(position = nil, board = self.class.default_board)
    super
    @single_move_offset = [-1, 0]
    @double_move_offset = [-2, 0]
    @kill_offsets = [[-1, -1], [-1, 1]]
    @double_move_row = 6
    @promotion_row = 0
  end
end
