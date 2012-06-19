require 'redmine'

# Permissions
Redmine::AccessControl.permission(:view_project).actions << "project_trackers/index"
Redmine::AccessControl.permission(:add_issues).actions << "issue_attributes/index"

Redmine::Plugin.register :redmine_fulmo_helper do
  name 'Posting issues helper API plugin'
  author 'OpenGroove, Inc.'
  description 'Add some APIs for helping to post issues via REST API.'
  version '1.0.0'
  url 'https://github.com/opengroove/redmine_fulmo_helper'
  author_url 'http://opengroove.com/'
end
