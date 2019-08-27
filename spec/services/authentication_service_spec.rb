RSpec.describe AuthenticationService do
  describe '.checks?' do
    let(:request) { double }

    it 'returns false when both methods are false' do
      allow(AuthenticationService::TokenMethod).to receive(:checks?) { false }
      allow(AuthenticationService::LoginMethod).to receive(:checks?) { false }

      expect(AuthenticationService.checks?(request)).to be_falsey
    end

    it 'returns true when one of each methods are true' do
      allow(AuthenticationService::TokenMethod).to receive(:checks?) { false }
      allow(AuthenticationService::LoginMethod).to receive(:checks?) { true }

      expect(AuthenticationService.checks?(request)).to be_truthy

      allow(AuthenticationService::TokenMethod).to receive(:checks?) { true }
      allow(AuthenticationService::LoginMethod).to receive(:checks?) { false }

      expect(AuthenticationService.checks?(request)).to be_truthy
    end

    it 'returns false when both methods are true' do
      allow(AuthenticationService::TokenMethod).to receive(:checks?) { true }
      allow(AuthenticationService::LoginMethod).to receive(:checks?) { true }

      expect(AuthenticationService.checks?(request)).to be_truthy
    end
  end
end
