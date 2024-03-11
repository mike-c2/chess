# frozen_string_literal: true

##
# This will implement color to an object.
# This module actually has no color, the
# child modules will define their own colors.
#
# Objects can be either white or black.
module Color
  BLACK = 'black'
  WHITE = 'white'
  NO_COLOR = ''
  WHITE_FONT_COLOR = "\e[37m"
  BLACK_FONT_COLOR = "\e[30m"
  NO_FONT_COLOR = ''

  def color
    NO_COLOR
  end

  def font_color
    NO_FONT_COLOR
  end

  def same_side?(_other)
    false
  end

  def opponents_side?(_other)
    false
  end

  def black?
    false
  end

  def white?
    false
  end

  def same_side_pieces
    []
  end

  def opponents_side_pieces
    []
  end

  def all_possible_moves
    pieces = same_side_pieces

    all_possible_moves_helper(pieces)
  end

  def all_possible_opponent_moves
    pieces = opponents_side_pieces

    all_possible_moves_helper(pieces)
  end

  private

  def all_possible_moves_helper(pieces)
    possible_moves = []

    pieces.each do |piece|
      piece_moves = piece.generate_possible_moves
      possible_moves.concat(piece_moves)
    end

    possible_moves
  end
end
