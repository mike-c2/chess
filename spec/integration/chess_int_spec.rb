# frozen_string_literal: true

require_relative '../../lib/chess'
require_relative '../../lib/board/board'

describe Chess do
  subject(:chess) { Chess.new(board) }
  let(:board) { Board.new }
  let(:white_control) { chess.white_control }
  let(:black_control) { chess.black_control }

  describe 'turn management' do
    it 'default starting turn is white' do
      active_control = chess.active_control

      expect(active_control).to be(white_control)
    end

    context "when it's white's turn" do
      describe '#white_turn' do
        it "it's white's turn" do
          chess.instance_variable_set(:@active_control, white_control)
          chess.whites_turn
          active_control = chess.active_control

          expect(active_control).to be(white_control)
        end
      end

      describe '#blacks_turn' do
        it "it's black's turn" do
          chess.instance_variable_set(:@active_control, white_control)
          chess.blacks_turn
          active_control = chess.active_control

          expect(active_control).to be(black_control)
        end
      end

      describe '#next_turn' do
        it "it's black's turn" do
          chess.instance_variable_set(:@active_control, white_control)
          chess.next_turn
          active_control = chess.active_control

          expect(active_control).to be(black_control)
        end
      end

      describe "#turn('red')" do
        it "it's white's turn" do
          chess.instance_variable_set(:@active_control, white_control)
          chess.turn('red')
          active_control = chess.active_control

          expect(active_control).to be(white_control)
        end
      end

      describe "#turn('white')" do
        it "it's white's turn" do
          chess.instance_variable_set(:@active_control, white_control)
          chess.turn('white')
          active_control = chess.active_control

          expect(active_control).to be(white_control)
        end
      end

      describe "#turn('black')" do
        it "it's black's turn" do
          chess.instance_variable_set(:@active_control, white_control)
          chess.turn('black')
          active_control = chess.active_control

          expect(active_control).to be(black_control)
        end
      end
    end

    context "when it's black's turn" do
      describe '#white_turn' do
        it "it's white's turn" do
          chess.instance_variable_set(:@active_control, black_control)
          chess.whites_turn
          active_control = chess.active_control

          expect(active_control).to be(white_control)
        end
      end

      describe '#blacks_turn' do
        it "it's black's turn" do
          chess.instance_variable_set(:@active_control, black_control)
          chess.blacks_turn
          active_control = chess.active_control

          expect(active_control).to be(black_control)
        end
      end

      describe '#next_turn' do
        it "it's white's turn" do
          chess.instance_variable_set(:@active_control, black_control)
          chess.next_turn
          active_control = chess.active_control

          expect(active_control).to be(white_control)
        end
      end

      describe "#turn('red')" do
        it "it's black's turn" do
          chess.instance_variable_set(:@active_control, black_control)
          chess.turn('red')
          active_control = chess.active_control

          expect(active_control).to be(black_control)
        end
      end

      describe "#turn('white')" do
        it "it's white's turn" do
          chess.instance_variable_set(:@active_control, black_control)
          chess.turn('white')
          active_control = chess.active_control

          expect(active_control).to be(white_control)
        end
      end

      describe "#turn('black')" do
        it "it's black's turn" do
          chess.instance_variable_set(:@active_control, black_control)
          chess.turn('black')
          active_control = chess.active_control

          expect(active_control).to be(black_control)
        end
      end
    end
  end
end
