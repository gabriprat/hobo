# -*- coding: utf-8 -*-
require 'test_helper'
require 'integration_test_helper'

class EditorsTest < ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
    @admin = create(:admin)
    @verify_list = []
  end

  teardown do
    DatabaseCleaner.clean
  end

  def use_editor(selector, value, text_value=nil)
    text_value ||= value
    assert find("#{selector} .in-place-edit").has_no_text?(text_value)
    find("#{selector} .in-place-edit").click
    find("#{selector} input[type=text],#{selector} textarea").set(value)
    find("h2.heading").click # just to get a blur
    assert page.find("#{selector} .in-place-edit").has_text?(text_value)
    @verify_list << { :selector => selector, :value => text_value }
  end


  test "editors" do
    Capybara.default_max_wait_time = 5
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
    click_link "editors"


    use_editor ".i-field .controls", "17"
    use_editor ".f-field .controls", "3.14159"
    use_editor ".dec-field .controls", "12.34"
    use_editor ".s-field .controls", "hello"
    use_editor ".tt-field .controls", "plain text"
    use_editor ".d-field .controls", Date.new(1973,4,8).to_s(:default)
#    use_editor ".dt-view", DateTime.new(1975,5,13,7,7).strftime(I18n.t(:"time.formats.default"))

    use_editor ".tl-field .controls", "_this_ is *textile*", "this is textile"
    use_editor ".md-field .controls", "*this* is **markdown**", "this is markdown"
    use_editor ".hh-field .controls", "<i>this</i> is <b>HTML</b>", "this is HTML"

    find(".bool1-field .controls input[type=checkbox]").click
    @verify_list << { :selector => ".bool1-field .controls", :value => "Yes" }

    find(".bool2-field .controls input[type=checkbox]").click
    sleep 0.2
    find(".bool2-field .controls input[type=checkbox]").click
    sleep 0.2
    @verify_list << { :selector => ".bool2-field .controls", :value => "No" }

    find(".es-field .controls select").select("C")
    @verify_list << { :selector => ".es-field .controls", :value => "C" }


    find("#bug305i input.foo-i").set("192")
    click_button "reload editors"
    assert find(".i-field .controls .in-place-edit").has_text?("192")

    find(".i-field .controls .in-place-edit").click
    find(".i-field .controls input[type=text]").set('17')
    find("h2.heading").click # just to get a blur
    assert find(".i-field .controls .in-place-edit").has_text?('17')

    click_link "exit editors"

    @verify_list.each {|v|
      assert_equal v[:value], find(v[:selector]).text, v[:selector]
    }

  end
end
