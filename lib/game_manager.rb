# frozen_string_literal: true

require_relative 'board/board'
require_relative 'chess'

board = Board.new
chess = Chess.new(board)
layout = BoardLayout.new(chess)

layout.setup('no_pawns')

chess.play_game
