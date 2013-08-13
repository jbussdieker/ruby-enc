require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @report = reports(:report_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should show report" do
    get :show, id: @report
    assert_response :success
  end

  test "should destroy " do
    assert_difference('Report.count', -1) do
      delete :destroy, id: @report
    end

    assert_redirected_to reports_path
  end
end
