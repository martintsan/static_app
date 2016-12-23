require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  def self.test_static_pages(page)
    test "should get #{page}" do
      get(send("static_pages_#{page}_url"))
      assert_response :success
      assert_select "title", "#{page.capitalize} | #{@base_title}"
    end
  end

  test_static_pages :home
  test_static_pages :help
  test_static_pages :about
end
