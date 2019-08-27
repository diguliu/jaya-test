RSpec.describe AuthenticationService::TokenMethod do
  describe '.token' do
    it 'fetches token from env' do
      expect(described_class.token).to eql(ENV['SECRET_TOKEN'])
    end
  end

  describe '.digest' do
    it 'generates digest from sha1' do
      expect(OpenSSL::Digest).to receive(:new).with('sha1')
      described_class.digest
    end
  end

  describe '.local_signature' do
    it 'works with nil body' do
      expect{ described_class.local_signature(nil) }.to_not raise_error
    end

    it 'build signature' do
      body = 'my-body'
      digest = described_class.digest
      token = described_class.token
      valid_signature = 'sha1=' + OpenSSL::HMAC.hexdigest(digest, token, body)

      expect(described_class.local_signature(body)).to eql(valid_signature)
    end
  end

  describe '.compare' do
    it 'compares using rack secure compare' do
      sign1 = double
      sign2 = double

      expect(Rack::Utils).to receive(:secure_compare).with(sign1, sign2)

      described_class.compare(sign1, sign2)
    end
  end

  describe '.checks?' do
    it 'expects body to be passed to local_signature' do
      request = double('request', body: double('body', read: 'body'), env: {})
      expect(described_class).to receive(:local_signature).with('body')

      described_class.checks?(request)
    end

    it 'is false when no signature was passed' do
      request = double('request', body: double('body', read: 'body'), env: {})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'is false when no signature was passed' do
      request = double('request', body: double('body', read: 'body'), env: {})
      expect(described_class.checks?(request)).to be_falsey
    end

    it 'returns false when singatures do not match' do
      sign = 'sha1=0ef7ac11eb30702ffdd34bd75109943435a51998'
      request = double('request', body: double('body', read: 'signature'), env: {'HTTP_X_HUB_SIGNATURE' => sign})

      expect(described_class.checks?(request)).to be_falsey
    end

    it 'returns true when singature matches' do
      sign = 'sha1=0ef7ac11eb30702ffdd34bd75109943435a51997'
      request = double('request', body: double('body', read: 'signature'), env: {'HTTP_X_HUB_SIGNATURE' => sign})

      expect(described_class.checks?(request)).to be_truthy
    end
  end
end
