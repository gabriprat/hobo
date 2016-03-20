# -*- coding: utf-8 -*-
require 'test_helper'
require 'integration_test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
    @admin = create(:admin)
    @project = create(:project, :name => "First Project", :owner => @admin)
    @s1 = create(:story, :project => @project, :title => "First Story", :body => "First Story")
  end

  teardown do
    DatabaseCleaner.clean
  end

  test "search" do
    visit root_path
    Capybara.current_session.driver.resize(1024,700)

    # log in as Administrator
    click_link "Log out" rescue Capybara::ElementNotFound
    click_link "Login"
    fill_in "login", :with => "admin@example.com"
    fill_in "password", :with => "test123"
    click_button "Login"
    assert has_content?("Logged in as Admin User")

    visit root_path

    fill_in "query", :with => "First"
    find("input[name=query]").native.send_key(:Enter)
    assert has_content?("Search Results")
    assert find("#search-results-box").has_content?("First Project")
    assert find("#search-results-box").has_content?("First Story")

  end
end
