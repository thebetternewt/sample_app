require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:chris)
    @non_admin = users(:archer)
    @non_activated_user = users(:lana)
  end

  test 'index including pagination and delete links' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    # Non-activated users should not appear on index.
    assert_select 'a[href=?]', user_path(@non_activated_user),
                               text: @non_activated_user.name,
                               count: 0
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      if user.activated?
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
