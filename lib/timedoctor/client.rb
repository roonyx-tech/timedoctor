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
    def initialize(token)
      @token = token
    end

    def absent_and_late
      TimeDoctor::Core::AbsentAndLate.new(@token)
    end

    def companies
      TimeDoctor::Core::Companies.new(@token)
    end

    def payrolls
      TimeDoctor::Core::Payrolls.new(@token)
    end

    def poortime
      TimeDoctor::Core::Poortime.new(@token)
    end

    def projects
      TimeDoctor::Core::Projects.new(@token)
    end

    def tasks
      TimeDoctor::Core::Tasks.new(@token)
    end

    def users
      TimeDoctor::Core::Users.new(@token)
    end

    def web_and_app
      TimeDoctor::Core::WebAndApp.new(@token)
    end

    def worklogs
      TimeDoctor::Core::Worklogs.new(@token)
    end
  end
end
