# frozen_string_literal: true

require_relative 'empty_piece'
require_relative 'board_display'

##
# This represents a Chess board which is stored in a
# 2-dimensional array of Chess Pieces.
class Board
  attr_accessor :check

  EMPTY_SPACE = EmptyPiece.new

  def initialize
    @check = false
    @grid = Array.new(8) { Array.new(8, EMPTY_SPACE) }
    @board_display = BoardDisplay.new(@grid)
  end

  def to_s
    @board_display.pretty_board
  end
end
