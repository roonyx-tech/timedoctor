require_relative 'core/base'

require_relative 'core/absent_late'
require_relative 'core/companies'
require_relative 'core/payrolls'
require_relative 'core/poortime'
require_relative 'core/projects'
require_relative 'core/tasks'
require_relative 'core/users'
require_relative 'core/web_app'
require_relative 'core/worklogs'

module TimeDoctor
  class Client
    CORE = TimeDoctor::Core

    def initialize(payload = {})
      raise EmptyAccessToken unless payload[:access_token]
      @worker = Worker.new(payload)
    end

    def absent_and_late
      CORE::AbsentAndLate.new(@worker)
    end

    def companies
      CORE::Companies.new(@worker)
    end

    def payrolls
      CORE::Payrolls.new(@worker)
    end

    def poortime
      CORE::Poortime.new(@worker)
    end

    def projects
      CORE::Projects.new(@worker)
    end

    def tasks
      CORE::Tasks.new(@worker)
    end

    def users
      CORE::Users.new(@worker)
    end

    def web_and_app
      CORE::WebAndApp.new(@worker)
    end

    def worklogs
      CORE::Worklogs.new(@worker)
    end
  end
end
