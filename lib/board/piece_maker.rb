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
  def created?(color:, type:, location:, move_count: 0, passant_vulnerable: false)
    return false unless %w[white black].include?(color)

    position = Position.create_with_chess_notation(location)

    return false unless position

    args = { type: type, position: position, move_count: move_count,
             passant_vulnerable: passant_vulnerable }

    piece = color == 'white' ? create_white(**args) : create_black(**args)

    return false unless piece

    @board.place(piece)

    true
  end

  private

  def create_white(type:, position:, move_count:, passant_vulnerable:)
    case type
    when 'king' then WhiteKing.new(position, @board, move_count)
    when 'queen' then WhiteQueen.new(position, @board, move_count)
    when 'bishop' then WhiteBishop.new(position, @board, move_count)
    when 'knight' then WhiteKnight.new(position, @board, move_count)
    when 'rook' then WhiteRook.new(position, @board, move_count)
    when 'pawn' then WhitePawn.new(position, @board, move_count, passant_vulnerable: passant_vulnerable)
    end
  end

  def create_black(type:, position:, move_count:, passant_vulnerable:)
    case type
    when 'king' then BlackKing.new(position, @board, move_count)
    when 'queen' then BlackQueen.new(position, @board, move_count)
    when 'bishop' then BlackBishop.new(position, @board, move_count)
    when 'knight' then BlackKnight.new(position, @board, move_count)
    when 'rook' then BlackRook.new(position, @board, move_count)
    when 'pawn' then BlackPawn.new(position, @board, move_count, passant_vulnerable: passant_vulnerable)
    end
  end
end
