require_relative '../spec_helper'

RSpec.describe 'Login' do
  before(:each) do
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless=new')
    options.add_argument('--no-sandbox')
    # This flag is a workaround for issues where a container runs out of memory.
    options.add_argument('--disable-dev-shm-usage')
    @driver = Selenium::WebDriver.for :chrome, options: options
  end

  after(:each) do
    @driver.quit
  end

  it 'logs in successfully' do
    @driver.navigate.to 'https://the-internet.herokuapp.com/login'
    @driver.find_element(id: 'username').send_keys 'tomsmith'
    @driver.find_element(id: 'password').send_keys 'SuperSecretPassword!'
    @driver.find_element(css: 'button[type=submit]').click

    flash_notice = @driver.find_element(id: 'flash')
    expect(flash_notice.text).to include('You logged into a secure area!')
  end
end
