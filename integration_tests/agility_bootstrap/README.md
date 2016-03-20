This is the integration test suite for Hobo.

# Installation

The tests expect that hobo\_bootstrap and hobo\_bootstrap\_ui are also available in the 
directory structure, at the same level as hobo. These are (currently) separate 
repositories.

Install [Firefox](http://www.getfirefox.net/download.html) & [Google Chrome](https://www.google.com/chrome/browser) browsers
in default locations.

Install the [Qt libraries](http://qt-project.org/downloads) for your OS. 

Install [ChromeDriver](http://code.google.com/p/selenium/wiki/ChromeDriver)

`gem install capybara-webkit` - Install [capybara-webkit](https://github.com/thoughtbot/capybara-webkit)

Make sure that you are in the hobo/integration\_tests/agility\_bootstrap directory.

`bundle install`. Do NOT run bundle update. Upgrading capybara often
breaks something somewhere.

`rake db:migrate`

If you are using a headless virtual machine, you should start a virtual display using Xvfb:

    sudo Xvfb :10 -ac
    export DISPLAY=:10

# Running

`rake test:integration`

`ruby -I test test/integration/ajax_form_test.rb`
