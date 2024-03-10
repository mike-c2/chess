# frozen_string_literal: true

require_relative 'board/board'
require_relative 'chess'

board = Board.new
chess = Chess.new(board)
layout = BoardLayout.new(chess)

layout.setup('black_kingside_rook')

chess.play_game
