# frozen_string_literal: true

##
# This class provides a way to print a chess board,
# along with all of the pieces present, to the
# terminal.
class BoardDisplay
  attr_reader :chess_board, :bg_colors

  BLACK_BG_COLOR = "\e[40m"
  RED_BG_COLOR = "\e[41m"
  GREEN_BG_COLOR = "\e[42m"
  YELLOW_BG_COLOR = "\e[43m"
  BLUE_BG_COLOR = "\e[44m"
  MAGENTA_BG_COLOR = "\e[45m"
  CYAN_BG_COLOR = "\e[46m"
  WHITE_BG_COLOR = "\e[47m"

  # Default terminal colors
  NO_COLOR = "\e[0m"

  # The Background colors are for alternating the chess board
  # square colors.
  def initialize(chess_board, first_bg_color = MAGENTA_BG_COLOR, second_bg_color = BLUE_BG_COLOR)
    @chess_board = chess_board
    @bg_colors = [first_bg_color, second_bg_color]
  end

  def pretty_board
    column_labels = column_headers
    board_string = "\n#{column_labels}"

    chess_board.reverse.each_with_index do |row, index|
      @bg_colors = [bg_colors.last, bg_colors.first]

      row_label = chess_board.length - index

      board_string = "#{board_string}#{board_row(row, row_label)}"
    end

    "#{board_string}#{column_labels}\n"
  end

  def column_headers
    first = 'A'.ord
    last = first + chess_board.first.length

    header = ' '

    (first...last).each do |letter|
      letter_formatted = letter.chr.center(6)
      header = "#{header} #{letter_formatted}"
    end

    "  #{header}\n"
  end

  def board_row(chess_row, row_label)
    padding = row_padding
    row_string = "   #{padding} #{row_label} "

    chess_row.each_with_index do |piece, index|
      current_color = index.even? ? bg_colors.first : bg_colors.last
      piece_formatted = piece.piece_str.center(7)
      row_string = "#{row_string}#{current_color}#{piece.font_color}#{piece_formatted}#{NO_COLOR}"
    end

    "#{row_string} #{row_label}\n   #{padding}"
  end

  def row_padding
    row = ''

    (0..7).each_with_index do |_, index|
      current_color = index.even? ? bg_colors.first : bg_colors.last
      row += "#{current_color}       #{NO_COLOR}"
    end

    "#{row}\n"
  end
end
