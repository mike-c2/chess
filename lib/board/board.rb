# frozen_string_literal: true

require_relative '../pieces/empty_piece'
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
    @grid.freeze
    @board_display = BoardDisplay.new(@grid)
  end

  def clear
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |_, column_index|
        @grid[row_index][column_index] = EMPTY_SPACE
      end
    end
  end

  def get(position)
    row, column = position.array_notation
    piece = @grid[row][column]

    return nil if piece.equal?(EMPTY_SPACE)

    piece
  end

  def place(piece)
    return nil unless piece.position

    return nil unless piece.black? || piece.white?

    old_piece = get(piece.position)
    row, column = piece.position.array_notation
    @grid[row][column] = piece

    old_piece
  end

  def remove(position)
    piece = get(position)

    return nil unless piece

    row, column = position.array_notation

    @grid[row][column] = EMPTY_SPACE

    piece
  end

  def all_pieces
    pieces = []

    @grid.each do |row|
      row.each do |piece|
        pieces.push(piece) if piece.black? || piece.white?
      end
    end

    pieces
  end

  def to_s
    @board_display.pretty_board
  end
end
