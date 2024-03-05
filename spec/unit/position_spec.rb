# frozen_string_literal: true

require_relative '../../lib/position'

describe Position do
  # new is private, must use factory method to get new Position object
  subject(:position) { described_class.create_with_array_notation(array_notation) }

  describe '.create_with_array_notation' do
    context 'when array_notation is nil' do
      let(:array_notation) { nil }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when array_notation is wrong object' do
      let(:array_notation) { double }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when array_notation is an Integer array of 1 item' do
      let(:array_notation) { [1] }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when array_notation is an Integer array of 3 items' do
      let(:array_notation) { [1, 2, 3] }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when first coordinate is not in the correct range' do
      let(:array_notation) { [-1, 7] }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when second coordinate is not in the correct range' do
      let(:array_notation) { [0, 8] }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when array_notation is valid' do
      let(:array_notation) { [row_coordinate, column_coordinate] }

      describe 'array_notation is [0, 0]' do
        let(:row_coordinate) { 0 }
        let(:column_coordinate) { 0 }
        let(:expected_chess_notation) { 'A1' }

        it 'described object is returned' do
          is_expected.to be_a(described_class)
        end

        describe 'described object getters' do
          it 'array_notation is correct' do
            expect(position.array_notation).to eq(array_notation)
          end

          it 'chess_notation is correct' do
            expect(position.chess_notation).to eq(expected_chess_notation)
          end
        end
      end

      describe 'array_notation is [1, 4]' do
        let(:row_coordinate) { 1 }
        let(:column_coordinate) { 4 }
        let(:expected_chess_notation) { 'E2' }

        it 'described object is returned' do
          is_expected.to be_a(described_class)
        end

        describe 'described object getters' do
          it 'array_notation is correct' do
            expect(position.array_notation).to eq(array_notation)
          end

          it 'chess_notation is correct' do
            expect(position.chess_notation).to eq(expected_chess_notation)
          end
        end
      end

      describe 'array_notation is [7, 7]' do
        let(:row_coordinate) { 7 }
        let(:column_coordinate) { 7 }
        let(:expected_chess_notation) { 'H8' }

        it 'described object is returned' do
          is_expected.to be_a(described_class)
        end

        describe 'described object getters' do
          it 'array_notation is correct' do
            expect(position.array_notation).to eq(array_notation)
          end

          it 'chess_notation is correct' do
            expect(position.chess_notation).to eq(expected_chess_notation)
          end
        end
      end
    end
  end

  describe '.create_with_chess_notation' do
    subject(:position) { described_class.create_with_chess_notation(chess_notation) }

    context 'when chess_notation is nil' do
      let(:chess_notation) { nil }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when chess_notation is in the wrong format' do
      let(:chess_notation) { 'cat5' }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when letter is not A to H' do
      let(:chess_notation) { 'I1' }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when number is too low' do
      let(:chess_notation) { 'B0' }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when number is too high' do
      let(:chess_notation) { 'C9' }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when chess_notation is valid ' do
      describe "chess_notation is 'A1'" do
        let(:chess_notation) { 'A1' }
        let(:expected_array_notation) { [0, 0] }

        it 'described object is returned' do
          is_expected.to be_a(described_class)
        end

        describe 'described object getters' do
          it 'array_notation is correct' do
            expect(position.array_notation).to eq(expected_array_notation)
          end

          it 'chess_notation is correct' do
            expect(position.chess_notation).to eq(chess_notation)
          end
        end
      end

      describe "chess_notation is 'G4'" do
        let(:chess_notation) { 'G2' }
        let(:expected_array_notation) { [1, 6] }

        it 'described object is returned' do
          is_expected.to be_a(described_class)
        end

        describe 'described object getters' do
          it 'array_notation is correct' do
            expect(position.array_notation).to eq(expected_array_notation)
          end

          it 'chess_notation is correct' do
            expect(position.chess_notation).to eq(chess_notation)
          end
        end
      end

      describe "chess_notation is 'H8'" do
        let(:chess_notation) { 'H8' }
        let(:expected_array_notation) { [7, 7] }

        it 'described object is returned' do
          is_expected.to be_a(described_class)
        end

        describe 'described object getters' do
          it 'array_notation is correct' do
            expect(position.array_notation).to eq(expected_array_notation)
          end

          it 'chess_notation is correct' do
            expect(position.chess_notation).to eq(chess_notation)
          end
        end
      end
    end
  end

  describe '#==' do
    let(:array_notation) { [2, 5] }
    let(:other_position) { described_class.create_with_array_notation(other_array_notation) }

    context 'when described objects are not equal' do
      describe 'both coordinates are not equal' do
        let(:other_array_notation) { [3, 4] }

        it 'returns false' do
          expect(position == other_position).to be(false)
        end
      end

      describe 'only first coordinate is equal' do
        let(:other_array_notation) { [2, 6] }

        it 'returns false' do
          expect(position == other_position).to be(false)
        end
      end

      describe 'only second coordinate is equal' do
        let(:other_array_notation) { [1, 5] }

        it 'returns false' do
          expect(position == other_position).to be(false)
        end
      end
    end

    context 'when described objects are equal' do
      let(:other_array_notation) { [2, 5] }

      it 'returns false' do
        expect(position == other_position).to be(true)
      end
    end
  end

  describe '#delta' do
    let(:array_notation) { [5, 4] }
    let(:other_position) { described_class.create_with_array_notation(other_array_notation) }

    context 'when the other object is nil' do
      it 'nil is returned' do
        expect(position.delta(nil)).to be_nil
      end
    end

    context 'when the other object is of the wrong type' do
      it 'nil is returned' do
        expect(position.delta('wrong')).to be_nil
      end
    end

    context 'when object with array_notation [5, 4]' do
      let(:other_array_notation) { [5, 4] }

      it '[0, 0] is returned' do
        expect(position.delta(other_position)).to eq([0, 0])
      end
    end

    context 'when object with array_notation [3, 1]' do
      let(:other_array_notation) { [3, 1] }

      it '[2, 3] is returned' do
        expect(position.delta(other_position)).to eq([2, 3])
      end
    end

    context 'when object with array_notation [7, 6]' do
      let(:other_array_notation) { [7, 6] }

      it '[-2, -2] is returned' do
        expect(position.delta(other_position)).to eq([-2, -2])
      end
    end
  end

  describe '#add_offset' do
    let(:array_notation) { [4, 5] }

    context 'when array_offset is nil' do
      let(:array_offset) { nil }

      it 'nil is returned' do
        new_position = position.add_offset(array_offset)
        expect(new_position).to be_nil
      end
    end

    context 'when array_offset is [0, 0]' do
      let(:array_offset) { [0, 0] }

      it 'new object with array_notation [4, 5] is returned' do
        new_position = position.add_offset(array_offset)
        expect(new_position.array_notation).to eq(array_notation)
      end
    end

    context 'when array_offset is [-1, -2]' do
      let(:array_offset) { [-1, -2] }
      let(:expected_array_notation) { [3, 3] }

      it 'new object with array_notation [3, 3] is returned' do
        new_position = position.add_offset(array_offset)
        expect(new_position.array_notation).to eq(expected_array_notation)
      end
    end

    context 'when array_offset is [2, 2]' do
      let(:array_offset) { [2, 2] }
      let(:expected_array_notation) { [6, 7] }

      it 'new object with array_notation [6, 7] is returned' do
        new_position = position.add_offset(array_offset)
        expect(new_position.array_notation).to eq(expected_array_notation)
      end
    end

    context 'when array_offset is [4, 3]' do
      let(:array_offset) { [4, 3] }

      it 'nil is returned because offset added too much' do
        new_position = position.add_offset(array_offset)
        expect(new_position).to be_nil
      end
    end

    context 'when array_offset is [-5, -6]' do
      let(:array_offset) { [-5, -6] }

      it 'nil is returned because offset subtracted too much' do
        new_position = position.add_offset(array_offset)
        expect(new_position).to be_nil
      end
    end
  end
end
