RSpec.describe AuthenticationService::LoginMethod do
  describe '.local_login' do
    it 'fetches login from env' do
      expect(described_class.local_login).to eql(ENV['LOGIN'])
    end
  end

  describe '.local_pass' do
    it 'fetches password from env' do
      expect(described_class.local_pass).to eql(ENV['PASSWORD'])
    end
  end

  describe '.checks?' do
    it 'is false when no login or password passed' do
      request = double('request', params: {login: nil, password: nil})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is false when only login passed' do
      request = double('request', params: {login: ENV['LOGIN'], password: nil})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is false when only password is passed' do
      request = double('request', params: {login: nil, password: ENV['PASSWORD']})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is false when login and password do not match' do
      request = double('request', params: {login: 'invalid login', password: 'invalid password'})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is false when only login matches' do
      request = double('request', params: {login: ENV['LOGIN'], password: 'invalid password'})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is false when only password matches' do
      request = double('request', params: {login: 'invalid login', password: ENV['PASSWORD']})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is true when both login and password matches' do
      request = double('request', params: {login: ENV['LOGIN'], password: ENV['PASSWORD']})
      expect(described_class.checks?(request)).to be_truthy
    end
  end
end
