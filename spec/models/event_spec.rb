require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { belong_to(:issue) }
  end

  describe '#issue' do
    it { is_expected.to validate_presence_of(:issue) }
  end

  describe '#action' do
    it { is_expected.to validate_presence_of(:action) }
  end
end
