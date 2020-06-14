require 'selenium-webdriver'

wd = Selenium::WebDriver.for :chrome
wd.get 'https://searchman.com/signin'
wd.find_element(:id, 'email').send_keys('kusumi@bond-y.com')
wd.find_element(:id, 'password').send_keys('myreco0825')
wd.find_element(:class, 'btn-primary').click
wd.save_screenshot('./screenshot.png')
wd.quit
