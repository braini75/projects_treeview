require File.expand_path('../../test_helper', __FILE__)

class TreeviewControllerTest < Redmine::ControllerTest
  fixtures :projects, :users, :email_addresses, :roles, :members, :member_roles, :enabled_modules

  def test_index_lists_public_projects_as_links
    get :index
    assert_response :success
    assert_select 'ul.projects-tree a[href=?]', '/projects/ecookbook'
  end

  def test_index_nests_subprojects_inside_their_parent
    get :index
    assert_select 'ul.projects-tree li.folder details ul a[href=?]', '/projects/subproject1'
  end

  def test_index_escapes_project_names
    Project.find(1).update_column(:name, '<script>alert(1)</script>')
    get :index
    assert_response :success
    assert_select 'ul.projects-tree script', 0
    assert_includes response.body, '&lt;script&gt;alert(1)&lt;/script&gt;'
  end

  def test_closed_projects_are_hidden_unless_requested
    Project.find(3).update_column(:status, Project::STATUS_CLOSED)

    get :index
    assert_response :success
    assert_select 'a[href=?]', '/projects/subproject1', 0

    get :index, :params => {:closed => 1}
    assert_response :success
    assert_select 'a.project-closed[href=?]', '/projects/subproject1'
  end
end
