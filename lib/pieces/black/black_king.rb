# frozen_string_literal: true

require_relative '../king'
require_relative '../colors/black'

##
# Represents the Black King in Chess.
class BlackKing < King
  include Black

  def piece_str
    "#{font_color}#{piece_type.capitalize}"
  end

  def to_s
    "#{color} #{piece_type}"
  end
end
