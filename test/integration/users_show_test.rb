require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:chris)
    @non_activated_user = users(:lana)
  end

  test 'user should be redirected when viewing non-activated user' do
    log_in_as @user
    get user_path(@non_activated_user)
    assert_redirected_to root_url
  end
end
