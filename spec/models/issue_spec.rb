require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'associations' do
    it { have_many(:events) }
  end
end
