require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  include UserTestHelper

  def setup
    log_in_new_user
  end

  def test_visit_ather_user_page
    visit user_path @friend
    assert page.has_content? @friend.name
    assert page.has_content? @friend.surname
    assert page.has_content?("User's activity")
    assert page.has_no_content?("Write your new post")
    assert page.has_content?("Add to friend")
    assert page.has_content?("Send message")
  end

end
