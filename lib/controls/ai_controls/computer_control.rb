# frozen_string_literal: true

require_relative '../control'

##
# Manages the computer's turn
# The computer will just randomly pick a valid move
# This is an abstract class
class ComputerControl < Control
  def play?
    possible_moves = valid_moves
    return false if possible_moves.empty?

    possible_moves.sample.move

    pawn_clean_up

    true
  end

  def pawn_clean_up
    same_side_pieces.each(&:no_prompt_promote)

    clear_en_passants
  end
end
