class Authentication::TokenMethod
  class << self
    def token
      ENV['SECRET_TOKEN']
    end

    def digest
      OpenSSL::Digest.new('sha1')
    end

    def local_signature(body)
      'sha1=' + OpenSSL::HMAC.hexdigest(digest, token, body.to_s)
    end

    def compare(local_sign, request_sign)
      Rack::Utils.secure_compare(local_sign, request_sign)
    end

    def checks?(request)
      local_signature = local_signature(request.body.read)
      request_signature = request.env['HTTP_X_HUB_SIGNATURE']

      return false if request_signature.blank?

      compare(local_signature, request_signature)
    end
  end
end
