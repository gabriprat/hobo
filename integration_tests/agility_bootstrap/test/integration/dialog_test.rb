# -*- coding: utf-8 -*-
require 'test_helper'
require 'integration_test_helper'

class DialosgTest < ActionDispatch::IntegrationTest
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

  test "dialog" do
    visit root_path
    Capybara.current_session.driver.resize(1024,700)

    # log in as Administrator
    click_link "Log out" rescue Capybara::ElementNotFound
    click_link "Login"
    fill_in "login", :with => "admin@example.com"
    fill_in "password", :with => "test123"
    click_button "Login"
    assert has_content?("Logged in as Admin User")

    visit "/projects/#{@project.id}/dialog_test"

    click_link "New Story"
    fill_in "story[title]", :with => "Another Story"
    fill_in "story[body]", :with => "body"
    click_button "Submit"

    assert find("#stories tbody tr.even td.this-view").has_content?("Another Story")
  end
end
