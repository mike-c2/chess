# frozen_string_literal: true

require_relative '../../lib/color'

describe Color do
  subject(:colored_object) { colored_class.new }
  let(:colored_class) { Class.new { include Color } }

  describe '#color' do
    it "only returns 'none'" do
      result = colored_object.color
      expect(result).to eq('none')
    end
  end

  describe '#font_color' do
    it 'only returns empty string' do
      result = colored_object.font_color
      expect(result).to eq('')
    end
  end

  describe '#same_side?' do
    it 'only returns false' do
      is_expected.not_to be_same_side(colored_object)
    end
  end

  describe '#opponents_side?' do
    it 'only returns false' do
      is_expected.not_to be_opponents_side(colored_object)
    end
  end
end
