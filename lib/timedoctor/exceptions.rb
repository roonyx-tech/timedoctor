module TimeDoctor
  class TimeDoctorError < StandardError
    def initialize(response)
      @code    = response.status
      @body    = JSON.parse(response.body)
      @message = create_message
    end

    attr_reader :code, :body, :message

    private

    def create_message
      message = indent("Code: #{@code}")
      @body.delete('code')
      @body.each { |k, v| message << indent("#{format k}: #{format v}") }
      message
    end

    def indent(str)
      "\n  #{str}"
    end

    def format(str)
      str.tr('_', ' ').capitalize
    rescue NoMethodError
      str
    end
  end

  class UnauthorizedError < TimeDoctorError; end

  class UnknownError < TimeDoctorError; end

  class InvalidRefreshTokenError < TimeDoctorError; end

  class EmptyAccessToken < StandardError
    attr_reader :message
    @message = 'The access token is not specified'
  end
end
