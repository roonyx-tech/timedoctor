require_relative 'client/base'

require_relative 'client/absent_late'
require_relative 'client/companies'
require_relative 'client/payrolls'
require_relative 'client/poortime'
require_relative 'client/projects'
require_relative 'client/tasks'
require_relative 'client/users'
require_relative 'client/web_app'
require_relative 'client/worklogs'

module TimeDoctor
  class Client
    def initialize(token)
      @token = token
    end

    def absent_and_late
      TimeDoctor::AbsentAndLate.new(@token)
    end

    def companies
      TimeDoctor::Companies.new(@token)
    end

    def payrolls
      TimeDoctor::Payrolls.new(@token)
    end

    def poortime
      TimeDoctor::Poortime.new(@token)
    end

    def projects
      TimeDoctor::Projects.new(@token)
    end

    def tasks
      TimeDoctor::Tasks.new(@token)
    end

    def users
      TimeDoctor::Users.new(@token)
    end

    def web_and_app
      TimeDoctor::WebAndApp.new(@token)
    end

    def worklogs
      TimeDoctor::Worklogs.new(@token)
    end
  end
end
