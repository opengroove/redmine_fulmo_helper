if Rails::VERSION::MAJOR >= 3
  get 'projects/:project_id/trackers.:format', :to => 'project_trackers#index'
  get 'projects/:project_id/issues/attributes.:format', :to => 'issue_attributes#index'
else
  ActionController::Routing::Routes.draw do |map|
    map.connect 'projects/:project_id/trackers.:format', :controller => 'project_trackers', :action => 'index'
    map.connect 'projects/:project_id/issues/attributes.:format', :controller => 'issue_attributes', :action => 'index'
  end
end
