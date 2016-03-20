# -*- coding: utf-8 -*-
require 'test_helper'
require 'integration_test_helper'

class LifecycleTest < ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
    @admin = create(:admin)
    @verify_list = []
  end

  teardown do
    DatabaseCleaner.clean
  end

  test "foos lifecycles" do
    visit root_path
    Capybara.current_session.driver.resize(1024,700)

    # log in as Administrator
    click_link "Log out" rescue Capybara::ElementNotFound
    click_link "Login"
    fill_in "login", :with => "admin@example.com"
    fill_in "password", :with => "test123"
    click_button "Login"
    assert has_content?("Logged in as Admin User")

    visit "/foos/new"
    click_button "Create Foo"
    find('input[value=Trans1]').click
    uncheck "foo[v]"
    click_button "Trans1"
    assert has_content?("v must be true")
    check "foo[v]"
    click_button "Trans1"
    click_button "Trans2"

  end
end
