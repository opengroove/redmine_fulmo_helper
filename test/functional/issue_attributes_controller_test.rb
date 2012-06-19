require File.expand_path('../../test_helper', __FILE__)

class IssueAttributesControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations,
           :workflows,
           :custom_fields,
           :custom_values,
           :custom_fields_projects,
           :custom_fields_trackers

  def setup
    @controller = IssueAttributesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 1
  end

  def xml
    Hash.from_xml(@response.body)
  end

  def test_index_with_anonymous
    @request.session[:user_id] = nil
    get :index, :project_id => 1, :format => "xml", :tracker_id => 1
    assert_response 401
  end

  def test_index_tracker1
    get :index, :project_id => 1, :format => "xml", :tracker_id => 1
    assert_response :success
    assert xml.key?("issue_attributes")
    assert xml["issue_attributes"]["standard_attributes"].size > 0
    assert xml["issue_attributes"]["standard_attributes"][0].key?("name")
    assert_equal ["1", "2", "6"], xml["issue_attributes"]["custom_attributes"].map{|i|i["id"]}.sort
  end

  def test_index_tracker2
    get :index, :project_id => 1, :format => "xml", :tracker_id => 2
    assert_response :success
    assert xml.key?("issue_attributes")
    assert xml["issue_attributes"]["standard_attributes"].size > 0
    assert xml["issue_attributes"]["standard_attributes"][0].key?("name")
    assert_equal ["6"], xml["issue_attributes"]["custom_attributes"].map{|i|i["id"]}.sort
  end
end
