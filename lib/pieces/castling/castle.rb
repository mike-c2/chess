# frozen_string_literal: true

require_relative '../../positionals/castling_move'

##
# This generates the Chess castling move.
class Castle
  def initialize(king, initial_king_position, board)
    @king = king
    @initial_king_position = initial_king_position
    @board = board

    @new_king_position = nil

    @initial_rook_position = nil
    @new_rook_position = nil

    @path = []
  end

  def generate_move
    return nil unless castling_possible?

    CastlingMove.create(@initial_king_position, @new_king_position, @initial_rook_position, @new_rook_position, @board)
  end

  private

  def castling_possible?
    king_ready? && rook_ready? && castle_path_clear? && king_path_safe?
  end

  def king_ready?
    return false unless @king.position == @initial_king_position

    return false if @king.in_check?

    @king.move_count.zero?
  end

  def rook_ready?
    piece = @board.get(@initial_rook_position)

    piece.is_a?(Rook) && @king.same_side?(piece) && piece.move_count.zero?
  end

  def castle_path_clear?
    @path.all? { |path_position| @board.get(path_position).nil? }
  end

  # King cannot move over a space that is in check to castle,
  # and cannot castle into check
  def king_path_safe?
    kings_path = [@new_king_position, @new_rook_position]

    kings_path.each do |new_position|
      return false unless king_new_position_safe?(new_position)
    end

    true
  end

  def king_new_position_safe?(new_position)
    return false unless @board.get(new_position).nil?

    current_position = @king.position

    @board.remove(@king.position)
    @king.position = new_position
    @board.place(@king)

    danger = @king.in_check?

    @board.remove(new_position)
    @king.position = current_position
    @board.place(@king)

    !danger
  end
end
