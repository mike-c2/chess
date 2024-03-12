# frozen_string_literal: true

require_relative 'empty_piece'
require_relative '../positionals/move'
require_relative '../board/piece_maker'

##
# Represents the Pawn in Chess.
# This is an abstract class, with
# no color.
class Pawn < EmptyPiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'pawn'
    @single_move_offset = []
    @double_move_offset = []
    @kill_offsets = []
    @double_move_row = -1
    @promotion_row = -1
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

  private

  def kill_moves
    possible_moves = []

    @kill_offsets.each do |offset|
      next_move = kill_move(offset)
      possible_moves << next_move if next_move
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

  def no_kill_moves
    possible_moves = []

    single_move = no_kill_move(@single_move_offset)
    possible_moves << single_move if single_move

    # If single move is not possible, then neither is double.
    # Double move can only happen on pawn's first move
    # Pawn must be in the correct starting row.
    if possible_moves.length.positive? && move_count.zero? && position.array_notation.first == @double_move_row
      double_move = no_kill_move(@double_move_offset)
      possible_moves << double_move if double_move
    end

    possible_moves
  end

  def no_kill_move(offset)
    next_position = position.add_offset(offset)
    return unless next_position

    return if @board.get(next_position)

    Move.create(position, next_position, @board)
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
