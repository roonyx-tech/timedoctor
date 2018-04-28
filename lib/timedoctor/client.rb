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

    def initialize(token)
      @token = token
    end

    def absent_and_late
      CORE::AbsentAndLate.new(@token)
    end

    def companies
      CORE::Companies.new(@token)
    end

    def payrolls
      CORE::Payrolls.new(@token)
    end

    def poortime
      CORE::Poortime.new(@token)
    end

    def projects
      CORE::Projects.new(@token)
    end

    def tasks
      CORE::Tasks.new(@token)
    end

    def users
      CORE::Users.new(@token)
    end

    def web_and_app
      CORE::WebAndApp.new(@token)
    end

    def worklogs
      CORE::Worklogs.new(@token)
    end
  end
end
