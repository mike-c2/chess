# frozen_string_literal: true

require_relative 'empty_piece'
require_relative '../positionals/move'
require_relative '../positionals/en_passant_move'
require_relative '../board/piece_maker'

##
# Represents the Pawn in Chess.
# This is an abstract class, with
# no color.
class Pawn < EmptyPiece
  def initialize(position = nil, board = self.class.default_board, move_count = 0, passant_vulnerable: false)
    super(position, board, move_count)
    self.piece_type = 'pawn'
    @single_move_offset = []
    @double_move_offset = []
    @kill_offsets = []
    @double_move_row = -1
    @promotion_row = -1
    @passant_vulnerable = passant_vulnerable
    @piece_maker = PieceMaker.new(@board)
  end

  def generate_possible_moves
    no_kill_moves + kill_moves
  end

  def promote
    return unless position.array_notation.first == @promotion_row

    choice = promotion_prompt
    process_promotion(choice)
  end

  def no_prompt_promote
    return unless position.array_notation.first == @promotion_row

    process_promotion('queen')
  end

  def enable_passant_vulnerable
    @passant_vulnerable = true
  end

  def disable_passant_vulnerable
    @passant_vulnerable = false
  end

  def to_h
    super.merge({ 'passant_vulnerable' => passant_vulnerable })
  end

  private

  def kill_moves
    possible_moves = []

    @kill_offsets.each do |offset|
      next_move = kill_move(offset)
      possible_moves << next_move if next_move

      en_passant_move = en_passant_kill_move(offset)
      possible_moves << en_passant_move if en_passant_move
    end

    possible_moves
  end

  def kill_move(offset)
    next_position = position.add_offset(offset)
    return nil unless next_position

    targeted_piece = @board.get(next_position)
    return nil unless targeted_piece

    return nil unless opponents_side?(targeted_piece)

    Move.create(position, next_position, @board)
  end

  def en_passant_kill_move(offset)
    next_position = position.add_offset(offset)
    return nil unless next_position

    return nil if @board.get(next_position)

    target_offset = [0, offset.last]
    target_position = position.add_offset(target_offset)
    targeted_piece = @board.get(target_position)
    return nil unless targeted_piece

    return nil unless opponents_side?(targeted_piece) && targeted_piece.passant_vulnerable

    EnPassantMove.create(position, next_position, target_position, @board)
  end

  def no_kill_moves
    possible_moves = []

    single_move = no_kill_move(@single_move_offset)
    possible_moves << single_move if single_move

    # If single move is not possible, then neither is double.
    # Double move can only happen on pawn's first move
    # Pawn must be in the correct starting row.
    if possible_moves.length.positive? && move_count.zero? && position.array_notation.first == @double_move_row
      double_move = no_kill_move(@double_move_offset, pre_passant_move: true)
      possible_moves << double_move if double_move
    end

    possible_moves
  end

  def no_kill_move(offset, pre_passant_move: false)
    next_position = position.add_offset(offset)
    return unless next_position

    return if @board.get(next_position)

    Move.create(position, next_position, @board, pre_passant_move: pre_passant_move)
  end

  def process_promotion(type)
    @piece_maker.created?(color: color, type: type, location: position.chess_notation)
    new_piece = @board.get(position)

    puts "\n#{self} has been promoted to #{new_piece}"
  end

  def promotion_prompt
    promotion_instructions
    options = { 'q' => 'queen', 'r' => 'rook', 'b' => 'bishop', 'k' => 'knight' }

    loop do
      choice = gets.chomp.strip.downcase
      choice = choice[0]
      return options[choice] if %w[q r b k].include?(choice)

      puts 'What you entered is not valid, try again.'
    end
  end

  def promotion_instructions
    puts <<~INSTRUCTIONS
      The #{self} will now be promoted, enter the piece that you want.

      Enter 'q' for queen
      Enter 'r' for rook
      Enter 'b' for bishop
      Enter 'k' for knight

      Anything after the first letter will be ignored, so 'qabc' will
      mean queen.  The input is not case sensitive.

    INSTRUCTIONS
  end
end
