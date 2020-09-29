require 'test_helper'

class PotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pots_new_url
    assert_response :success
  end

end
