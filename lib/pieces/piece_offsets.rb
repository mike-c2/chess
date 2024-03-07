# frozen_string_literal: true

##
# This defines how each chess piece moves, relative
# to its current position.
#
# Pawns are not included in this since their movements
# are more specialized.
module PieceOffsets
  UP = [1, 0].freeze
  DOWN = [-1, 0].freeze
  LEFT = [0, -1].freeze
  RIGHT = [0, 1].freeze
  UP_LEFT = [1, -1].freeze
  UP_RIGHT = [1, 1].freeze
  DOWN_LEFT = [-1, -1].freeze
  DOWN_RIGHT = [-1, 1].freeze

  ROOK_OFFSETS = [UP, DOWN, LEFT, RIGHT].freeze
  BISHOP_OFFSETS = [UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT].freeze
  QUEEN_OFFSETS = ROOK_OFFSETS.dup.concat(BISHOP_OFFSETS).freeze
  KING_OFFSETS = QUEEN_OFFSETS
  KNIGHT_OFFSETS = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                    [2, 1], [2, -1], [-2, 1], [-2, -1]].freeze
end
