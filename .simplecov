SimpleCov.start do
  coverage_dir "#{SimpleCov.root}/tmp/simplecov/"
  add_filter 'spec'
end

if ENV['CODECOV_TOKEN']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov 
end
