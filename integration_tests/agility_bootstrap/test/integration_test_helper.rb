require 'capybara'
require 'capybara/dsl'
require 'database_cleaner'
require 'capybara-screenshot'
require 'capybara-screenshot/minitest'
require 'capybara/poltergeist'


Capybara.app = Agility::Application
DatabaseCleaner.strategy = :truncation



Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :timeout => 30, :js_errors => false)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
Capybara.current_driver = :poltergeist

class ActiveSupport::TestCase
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...

end
