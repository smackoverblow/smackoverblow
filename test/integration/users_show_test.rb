require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @michael = users(:michael)
    @archer = users(:archer)
    @lana = users(:lana)
  end

  test "should redirect to root_url if not activated" do
    get users_path
    log_in_as @michael
    assert is_logged_in?
  end
end
