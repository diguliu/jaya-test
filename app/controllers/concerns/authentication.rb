class Authentication
  class << self
    def checks?(request)
      TokenMethod.checks?(request) || LoginMethod.checks?(request)
    end
  end
end
