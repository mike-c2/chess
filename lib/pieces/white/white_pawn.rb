# frozen_string_literal: true

require_relative '../pawn'
require_relative '../../colors/white'

##
# Represents the White Pawn in Chess.
class WhitePawn < Pawn
  include White

  def initialize(position = nil, board = self.class.default_board, move_count = 0, passant_vulnerable: false)
    super
    @single_move_offset = [1, 0]
    @double_move_offset = [2, 0]
    @kill_offsets = [[1, -1], [1, 1]]
    @double_move_row = 1
    @promotion_row = 7
  end
end
