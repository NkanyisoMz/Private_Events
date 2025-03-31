require "test_helper"

class EventAttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_attendances_create_url
    assert_response :success
  end

  test "should get destroy" do
    get event_attendances_destroy_url
    assert_response :success
  end
end
