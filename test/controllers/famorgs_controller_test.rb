require 'test_helper'

class FamorgsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get famorgs_index_url
    assert_response :success
  end

  test "should get show" do
    get famorgs_show_url
    assert_response :success
  end

  test "should get new" do
    get famorgs_new_url
    assert_response :success
  end

  test "should get edit" do
    get famorgs_edit_url
    assert_response :success
  end

end
