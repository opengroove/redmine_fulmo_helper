require File.expand_path('../../test_helper', __FILE__)

class ProjectTrackersControllerTest < ActionController::TestCase
  fixtures :trackers, :projects, :projects_trackers, :users

  def setup
    @controller = ProjectTrackersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 2
  end

  def xml
    Hash.from_xml(@response.body)
  end

  def test_index_to_public_project_with_anonymous
    @request.session[:user_id] = nil
    get :index, :project_id => 1, :format => "xml"
    assert_response :success
  end

  def test_index_to_private_project_with_anonymous
    @request.session[:user_id] = nil
    get :index, :project_id => 2, :format => "xml"
    assert_response 401
  end

  def test_index_to_project1
    get :index, :project_id => 1, :format => "xml"
    assert_response :success
    assert_equal [["1", "Bug"], ["2", "Feature request"], ["3", "Support request"]], xml["trackers"].map{|i|[i["id"], i["name"]]}.sort
  end

  def test_index_to_project3
    get :index, :project_id => 3, :format => "xml"
    assert_response :success
    assert_equal [["2", "Feature request"], ["3", "Support request"]], xml["trackers"].map{|i|[i["id"], i["name"]]}.sort
  end
end
