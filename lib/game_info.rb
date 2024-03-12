# frozen_string_literal: true

##
# Provides information and instruction on how
# to play this Chess game.
#
# This does not explain how to actually play
# the game of Chess, just how to make moves
# using this version of Chess.
module GameInfo
  def self.display
    puts <<~INFO

      Welcome to this game of Chess!

      This is can only be played in 2-player mode, there is no AI.

      Enter the move you want to make using Chess notation.
      For example, if you want to move the pawn on E2 up to E4, enter the
      following notation (input is case insensitive):

      E2 E4

      This is how all pieces on the board are moved, by entering the
      starting location followed by the ending location.  This includes
      moves that captures an opponent's piece and castling.

      For castling, move the King over to the left or right 2 spaces,
      then the Rook will automatically move as well.

      For pawn promotions, you will be prompted to select what the new
      piece will be.

      You can also enter 'menu' to go back to the Main Menu.

    INFO
  end
end
