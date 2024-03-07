# frozen_string_literal: true

require_relative '../king'
require_relative '../colors/white'

##
# Represents the White King in Chess.
class WhiteKing < King
  include White

  def piece_str
    "#{font_color}#{piece_type.capitalize}"
  end

  def to_s
    "#{color} #{piece_type}"
  end
end
