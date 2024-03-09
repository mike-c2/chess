# frozen_string_literal: true

require_relative '../pieces/all_colored_pieces'
require_relative '../positionals/position'

##
# This class provides an easier way to generate
# chess pieces and place them on the board.
class PieceMaker
  def initialize(board)
    @board = board
  end

  ##
  # Creates a Chess piece and places it on the board.
  #
  # Example: created?(color: 'white', type: 'king', location: 'E1')
  #
  # Returns true if the action was successful, false otherwise
  def created?(color:, type:, location:)
    color = color.chomp.strip.downcase
    type = type.chomp.strip.downcase

    return false unless %w[white black].include?(color)

    position = Position.create_with_chess_notation(location)

    return false unless position

    piece = color == 'white' ? create_white(type, position) : create_black(type, position)

    return false unless piece

    @board.place(piece)

    true
  end

  private

  def create_white(type, position)
    case type
    when 'king' then WhiteKing.new(position, @board)
    when 'queen' then WhiteQueen.new(position, @board)
    when 'bishop' then WhiteBishop.new(position, @board)
    when 'knight' then WhiteKnight.new(position, @board)
    when 'rook' then WhiteRook.new(position, @board)
    when 'pawn' then WhitePawn.new(position, @board)
    end
  end

  def create_black(type, position)
    case type
    when 'king' then BlackKing.new(position, @board)
    when 'queen' then BlackQueen.new(position, @board)
    when 'bishop' then BlackBishop.new(position, @board)
    when 'knight' then BlackKnight.new(position, @board)
    when 'rook' then BlackRook.new(position, @board)
    when 'pawn' then BlackPawn.new(position, @board)
    end
  end
end
