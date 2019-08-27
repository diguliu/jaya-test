class Authentication::LoginMethod
  class << self
    def local_login
      ENV['LOGIN']
    end

    def local_pass
      ENV['PASSWORD']
    end

    def checks?(request)
      login = request.params[:login]
      password = request.params[:password]

      return false if login.blank? || password.blank?

      login == local_login && password == local_pass
    end
  end
end
