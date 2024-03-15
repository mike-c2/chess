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

  def in_check?
    in_check_helper?(all_possible_opponent_moves)
  end

  def opponent_in_check?
    in_check_helper?(all_possible_moves)
  end

  def all_possible_moves
    pieces = same_side_pieces

    all_possible_moves_helper(pieces) + all_castling_moves
  end

  # This does not include castling moves.
  # This is needed for the check test and
  # being able to castle will never
  # threaten the King.
  def all_possible_opponent_moves
    pieces = opponents_side_pieces

    all_possible_moves_helper(pieces)
  end

  def all_castling_moves
    possible_moves = []

    same_side_pieces.each do |piece|
      piece_moves = piece.generate_castling_moves
      possible_moves.concat(piece_moves)
    end

    possible_moves
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

  def in_check_helper?(moves)
    positions = moves.map(&:ending_position)

    positions.any? do |position|
      piece = @board.get(position)

      next unless piece

      piece.is_a?(King)
    end
  end
end
