# frozen_string_literal: true

require_relative 'castle'

##
# This generates the Kingside Chess castling move.
class KingsideCastle < Castle
  def initialize(king, initial_king_position, board)
    super

    @new_king_position = @initial_king_position.add_offset([0, 2])

    @initial_rook_position = @initial_king_position.add_offset([0, 3])
    @new_rook_position = @initial_king_position.add_offset([0, 1])

    @path = [@new_rook_position, @new_king_position]
  end
end
