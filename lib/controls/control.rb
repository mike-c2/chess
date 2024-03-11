# frozen_string_literal: true

require_relative '../board/board'
require_relative '../colors/color'
require_relative '../positionals/move'

##
# Manages a player's turn
# This is an abstract class.
class Control
  include Color

  def initialize(board)
    @board = board
  end

  def play
    possible_moves = all_possible_moves.reject { |move| move_own_check?(move) }

    loop do
      move_choice = player_move

      if possible_moves.include?(move_choice)
        move_choice.move
        break
      end

      puts 'Your move is not possible, try again.'
    end

    promote_eligible_pieces
  end

  private

  def player_move
    puts "It is now #{color.capitalize}'s turn, make a move:"

    loop do
      first, second = gets.chomp.strip.split
      first_position = Position.create_with_chess_notation(first)
      second_position = Position.create_with_chess_notation(second)

      move = Move.create(first_position, second_position, @board)

      return move if move

      puts 'Move entered is not valid, try again.  An example of a valid move: E2 E4'
    end
  end

  def promote_eligible_pieces
    same_side_pieces.each(&:promote)
  end

  # This performs the actual move on the board,
  # check to see if it results in the side making
  # the move being in check, then undoes the move
  # on the board.
  def move_own_check?(move)
    starting_position = move.starting_position
    ending_position = move.ending_position

    moving_piece = @board.remove(starting_position)
    moving_piece.position = ending_position
    captured_piece = @board.place(moving_piece)

    check = in_check?

    moving_piece.position = starting_position
    @board.place(moving_piece)

    captured_piece ? @board.place(captured_piece) : @board.remove(ending_position)

    check
  end
end
